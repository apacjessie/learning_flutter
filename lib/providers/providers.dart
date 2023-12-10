import 'package:flutter/material.dart';
import 'package:sample_flutter/class/todos.dart';
import 'package:sample_flutter/class/user.dart';
import 'package:sample_flutter/main.dart';

class Providers extends ChangeNotifier {
  bool _isLoggedIn = false;
  String _userId = "";
  final List<User> _users = [];

  bool get isLoggedIn => _isLoggedIn;
  String get userId => _userId;
  List<User> get users => _users;
  List<Todos> get userTodos {
    User? user = findUserById(_userId);
    return user?.todos ?? [];
  }

  User? isCredentialValid(String username, String password) {
    for (User user in _users) {
      if (user.username == username && user.password == password) {
        return user;
      }
    }
    return null;
  }

  String? getUsername() {
    User? user = findUserById(_userId);
    if (user != null) {
      return user.username;
    }
    return null;
  }

  void login(String userId) {
    _isLoggedIn = true;
    _userId = userId;
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    _userId = "";
    notifyListeners();
  }

  void addUser(String username, String password) {
    users.add(User(
      generateRandomId(),
      username,
      password,
    ));
    notifyListeners();
  }

  User? findUserById(String userId) {
    try {
      return _users.firstWhere((user) => user.id == userId);
    } catch (_) {
      return null;
    }
  }

  void addTask(task) {
    User? user = findUserById(_userId);
    if (user != null) {
      user.todos.add(Todos(userId, task));
    }
    notifyListeners();
  }

  void deleteTask(String id) {
    User? user = findUserById(_userId);
    if (user != null) {
      user.todos.removeWhere((task) => task.id == id);
    }
    notifyListeners();
  }

  void toggleTaskCompletion(String id) {
    User? user = findUserById(_userId);
    if (user != null) {
      final task = user.todos.firstWhere((task) => task.id == id);
      task.isComplete = !task.isComplete;
    }
    notifyListeners();
  }

  void clearAllComplete() {
    User? user = findUserById(_userId);
    if (user != null) {
      user.todos.removeWhere((task) => task.isComplete);
    }
    notifyListeners();
  }
}
