import 'package:checkmate/class/todos.dart';

class User {
  String id;
  String username;
  String password;
  List<Todos> todos = [];
  User(this.id, this.username, this.password, this.todos);
}
