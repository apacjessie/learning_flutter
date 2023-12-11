<?php

header('Access-Control-Allow-Origin: *'); 
header('Access-Control-Allow-Headers: Content-Type, Authorization');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS');
header('Content-Type: application/json');
$file = 'data.json';
$data = file_get_contents($file);
$array = json_decode($data, true) ?? [];

class Todo {
    public  $id;
    public $task;
    public  $isComplete;
    public function __construct($id, $task,$isComplete) {
        $this->id = $id;
        $this->task = $task;
        $this->isComplete = $isComplete;
    }
}

class User {
    public $id;
    public $username;
    public $password;
    public $todos;

    public function __construct($id, $username, $password, $todos) {
        $this->id = $id;
        $this->username = $username;
        $this->password = $password;
        $this->todos = $todos;
    }


    public function toAssociativeArray () {
        return [
            'id' => $this->id,
            'username' => $this->username,
            'password' => $this->password,
            'todos' => array_values($this->todos)
        ];
    }

    public function addTask($task) {
        $newTask = new Todo(uniqid(),$task, false );
        $this->todos[] = $newTask;
    }

    public function deleteTask($taskId){
        $this->todos = array_values(array_filter($this->todos, function ($task) use ($taskId) {
            return $task['id'] !== $taskId;
        }));
    } 

    public function toggleTaskCompletion($taskId) {
        foreach ($this->todos as &$task) {
            if ($task['id'] === $taskId) {
                $task['isComplete'] = !$task['isComplete'];
                return;
            }
        }
    }

    public function clearCompleteTask() {
        $this->todos = array_filter($this->todos, function ($task)  {
            return $task['isComplete'] !== true;
        });
    }
}


if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    
    echo json_encode(['status' => 'success', 'response' => $array]);
} 
else if($_SERVER['REQUEST_METHOD'] === "POST") {
    $body = json_decode(file_get_contents("php://input"), true);
    if($body['type'] === 'login') {
        $username = $body['username'];
        $password = $body['password'];

        foreach($array as &$user) {
            if($user['username'] === $username && $user['password'] === $password) {
                echo json_encode(['status'=>'success', 'response'=>$user]);
                return;
            }
        }
        echo json_encode(['status'=>'Unauthorized','message'=>'Invalid username and/or password']);
    }
    if($body['type'] === 'register') {
        $username = $body['username'];
        $password = $body['password'];
        $newUser = new User(uniqid(), $username, $password, []);
        $array[] = $newUser->toAssociativeArray();
        file_put_contents($file, json_encode($array));
        echo json_encode(['status'=>'success']);
    }
    if($body['type'] === 'addTask') {
        $userId = $body['userId'];
        $task = $body['task'];

        foreach($array as &$user) {
            if($user['id'] == $userId) {
                $userObject = new User($user['id'],$user['username'],$user['password'],$user['todos']);
                $userObject->addTask($task);
                $user['todos'] = $userObject->todos;
                file_put_contents($file, json_encode($array));
                echo json_encode(['status'=>'success', 'response'=>$user['todos']]);
                return;
            
            }
        }
        echo json_encode(['status'=>'error', 'message'=>'user not found']);

    }
    if($body['type'] === 'deleteTask') {
        $userId = $body['userId'];
        $taskId = $body['taskId'];

        foreach($array as &$user) {
            if($user['id'] == $userId) {
                $userObject = new User($user['id'],$user['username'],$user['password'],$user['todos']);
                $userObject->deleteTask($taskId);
                $user['todos'] = $userObject->todos;
                file_put_contents($file, json_encode($array));
                echo json_encode(['status'=>'success', 'response'=>$user['todos']]);
                return;
            
            }
        }
        echo json_encode(['status'=>'error', 'message'=>'user not found', 'response'=>[]]);
    }  
    if($body['type'] === 'toggleTaskCompletion') {
        $userId = $body['userId'];
        $taskId = $body['taskId'];

        foreach ($array as &$user) {
            if ($user['id'] == $userId) {
                $userObject = new User($user['id'], $user['username'], $user['password'], $user['todos']);
                $userObject->toggleTaskCompletion($taskId);
                $user['todos'] = $userObject->todos;
                file_put_contents($file, json_encode($array));
                echo json_encode(['status' => 'success', 'response' => $user['todos']]);
                return;
            }
        }

        echo json_encode(['status' => 'error', 'message' => 'User not found']);
    }
    if($body['type'] === 'clearCompleteTask') {
        $userId = $body['userId'];

        foreach ($array as &$user) {
            if ($user['id'] == $userId) {
                $userObject = new User($user['id'], $user['username'], $user['password'], $user['todos']);
                $userObject->clearCompleteTask();
                $user['todos'] = $userObject->todos;
                file_put_contents($file, json_encode($array));
                echo json_encode(['status' => 'success', 'response' => $user['todos']]);
                return;
            }
        }

        echo json_encode(['status' => 'error', 'message' => 'User not found']);
    }
   
}
else {
    echo json_encode(['status' => 'error', 'message' => 'Invalid request method']);
}


?>
