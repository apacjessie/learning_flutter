// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:sample_flutter/class/todos.dart';
import 'package:sample_flutter/class/user.dart';
import 'package:sample_flutter/main.dart';

class Providers extends ChangeNotifier {
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;
  String get username => loggedUser.username;
  final List<User> _users = [];
  List<Todos> _loggedUserTodos = [];

  User loggedUser = User("", "", "", []);

  List<Todos> get todos => _loggedUserTodos;

  void register(String username, String password) {
    _users.add(User(generateRandomId(), username, password, []));
    notifyListeners();
  }

  void toggleTaskCompletion(String taskId) {
    User foundUser = _users.firstWhere((user) => user.id == loggedUser.id);
    int taskIndex = foundUser.todos.indexWhere((task) => task.id == taskId);

    if (taskIndex != -1) {
      foundUser.todos[taskIndex].isComplete =
          !foundUser.todos[taskIndex].isComplete;
      loggedUser = foundUser;
      notifyListeners();
    }
  }

  bool isCredentialValid(String username, String password) {
    try {
      User foundUser = _users.firstWhere(
        (user) => user.username == username && user.password == password,
      );
      login(foundUser);
      return true;
    } catch (e) {
      return false;
    }
  }

  void addTask(String task) {
    User user = _users.firstWhere((user) => user.id == loggedUser.id);
    user.todos.add(Todos(generateRandomId(), task, false));
    _loggedUserTodos = user.todos;
    notifyListeners();
  }

  void deleteTask(String taskId) {
    User user = _users.firstWhere((user) => user.id == loggedUser.id);
    user.todos.removeWhere((task) => task.id == taskId);
    loggedUser = user;
    notifyListeners();
  }

  void clearCompleteTask() {
    User user = _users.firstWhere((user) => user.id == loggedUser.id);
    user.todos.removeWhere((element) => element.isComplete);
    loggedUser = user;
    _loggedUserTodos = user.todos;
    notifyListeners();
  }

  void login(User user) {
    _isLoggedIn = true;
    loggedUser = User(user.id, user.username, user.password, user.todos);
    _loggedUserTodos = loggedUser.todos;
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    loggedUser = User("", "", "", []);
    _loggedUserTodos = loggedUser.todos;
    notifyListeners();
  }
}
