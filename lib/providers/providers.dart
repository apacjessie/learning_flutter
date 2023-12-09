import 'package:flutter/material.dart';
import 'package:sample_flutter/class/todos.dart';

class Providers extends ChangeNotifier {
  bool _isLoggedIn = false;
  String _username = "";
  final List<Todos> _todos = [];

  bool get isLoggedIn => _isLoggedIn;
  String get username => _username;
  List<Todos> get todos => _todos;

  void login(String username) {
    _isLoggedIn = true;
    _username = username;
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    _username = "";
    notifyListeners();
  }

  void addTask(id, task) {
    _todos.add(Todos(id, task));
    notifyListeners();
  }

  void deleteTask(String id) {
    _todos.removeWhere((task) => task.id == id);
    notifyListeners();
  }

  void toggleTaskCompletion(String id) {
    final task = _todos.firstWhere((task) => task.id == id);
    task.isComplete = !task.isComplete;
    notifyListeners();
  }

  void clearAllComplete() {
    _todos.removeWhere((task) => task.isComplete);
    notifyListeners();
  }
}
