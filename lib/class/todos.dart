class Todos {
  String id;
  String task;
  bool isComplete;

  Todos(this.id, this.task, {this.isComplete = false});

  Map<String, dynamic> toJson() {
    return {'id': id, 'task': task, 'isComplete': isComplete};
  }
}
