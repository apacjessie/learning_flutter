// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sample_flutter/class/todos.dart';
import 'package:sample_flutter/class/user.dart';
import 'package:sample_flutter/main.dart';
import 'package:http/http.dart' as http;

class Providers extends ChangeNotifier {
  String url = 'http://localhost:8080/api.php';

  bool _isLoggedIn = false;

  User _user = User("", "", "");
  List<Todos> _todos = [];
  bool get isLoggedIn => _isLoggedIn;
  String get username => _user.username;

  List<Todos> get todos => _todos;

  // List<Todos> get userTodos {
  //   User? user = findUserById(_userId);
  //   return user?.todos ?? [];
  // }

  Future<User?> isCredentialValid(String username, String password) async {
    try {
      http.Response response = await http.post(Uri.parse(url),
          body: jsonEncode(
              {'type': 'login', 'username': username, 'password': password}));
      Map<String, dynamic> data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        Map<String, dynamic> res = data['response'];
        User user = User(res['id'], res['username'], res['password']);
        List<Todos> todos = (res['todos'] as List)
            .map((todo) => Todos(todo['id'], todo['task'], todo['isComplete']))
            .toList();
        _todos = todos;
        notifyListeners();
        return user;
      } else {
        return null;
      }
    } catch (e) {
      print('Error $e');
      return null;
    }
  }

  Future register(String username, String password) async {
    try {
      http.Response response = await http.post(Uri.parse(url),
          body: jsonEncode({
            'type': 'register',
            'username': username,
            'password': password
          }));
      if (response.statusCode == 200) {
        return true;
      } else {
        return null;
      }
    } catch (e) {
      print('Error $e');
    }
  }

  Future addTask(String task) async {
    try {
      http.Response response = await http.post(Uri.parse(url),
          body: jsonEncode(
              {'type': 'addTask', 'userId': _user.id, 'task': task}));
      Map<String, dynamic> data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        List<Todos> todos = (data['response'] as List)
            .map((todo) => Todos(todo['id'], todo['task'], todo['isComplete']))
            .toList();
        _todos = todos;
        notifyListeners();
        return true;
      } else {
        return null;
      }
    } catch (e) {
      print('Error $e');
    }
  }

  Future deleteTask(String taskId) async {
    try {
      http.Response response = await http.post(Uri.parse(url),
          body: jsonEncode(
              {'type': 'deleteTask', 'userId': _user.id, 'taskId': taskId}));
      Map<String, dynamic> data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        List<Todos> todos = (data['response'] as List)
            .map((todo) => Todos(todo['id'], todo['task'], todo['isComplete']))
            .toList();
        _todos = todos;
        notifyListeners();
        return true;
      } else {
        return null;
      }
    } catch (e) {
      print('Error $e');
    }
  }

  Future toggleTaskCompletion(String taskId) async {
    try {
      http.Response response = await http.post(Uri.parse(url),
          body: jsonEncode({
            'type': 'toggleTaskCompletion',
            'userId': _user.id,
            'taskId': taskId
          }));
      Map<String, dynamic> data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        List<Todos> todos = (data['response'] as List)
            .map((todo) => Todos(todo['id'], todo['task'], todo['isComplete']))
            .toList();
        _todos = todos;
        notifyListeners();
        return true;
      } else {
        return null;
      }
    } catch (e) {
      print('Error $e');
    }
  }

  Future clearCompleteTask() async {
    try {
      http.Response response = await http.post(Uri.parse(url),
          body: jsonEncode({
            'type': 'clearCompleteTask',
            'userId': _user.id,
          }));
      Map<String, dynamic> data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        List<Todos> todos = (data['response'] as List)
            .map((todo) => Todos(todo['id'], todo['task'], todo['isComplete']))
            .toList();
        _todos = todos;
        notifyListeners();
        return true;
      } else {
        return null;
      }
    } catch (e) {
      print('Error $e');
    }
  }

  void login(User user) {
    _isLoggedIn = true;
    _user = user;
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    _user = User("", "", "");

    notifyListeners();
  }

  // void addUser(String username, String password) {
  //   users.add(User(
  //     generateRandomId(),
  //     username,
  //     password,
  //   ));
  //   notifyListeners();
  // }

  // User? findUserById(String userId) {
  //   try {
  //     return _users.firstWhere((user) => user.id == userId);
  //   } catch (_) {
  //     return null;
  //   }
  // }

  // void addTask(task) {
  //   User? user = findUserById(_userId);
  //   if (user != null) {
  //     user.todos.add(Todos(generateRandomId(), task));
  //   }
  //   notifyListeners();
  // }

  // void deleteTask(String id) {
  //   User? user = findUserById(_userId);
  //   if (user != null) {
  //     user.todos.removeWhere((task) => task.id == id);
  //   }
  //   notifyListeners();
  // }

  // void toggleTaskCompletion(String id) {
  //   User? user = findUserById(_userId);
  //   if (user != null) {
  //     final task = user.todos.firstWhere((task) => task.id == id);
  //     task.isComplete = !task.isComplete;
  //   }
  //   notifyListeners();
  // }

  // void clearAllComplete() {
  //   User? user = findUserById(_userId);
  //   if (user != null) {
  //     user.todos.removeWhere((task) => task.isComplete);
  //   }
  //   notifyListeners();
  // }
}
