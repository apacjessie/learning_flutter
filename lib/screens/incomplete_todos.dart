import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_flutter/class/todos.dart';
import 'package:sample_flutter/components/tile.dart';
import 'package:sample_flutter/providers/providers.dart';

class IncompleteTodos extends StatelessWidget {
  const IncompleteTodos({super.key});

  @override
  Widget build(BuildContext context) {
    List<Todos> todos = Provider.of<Providers>(context, listen: true)
        .userTodos
        .where((task) => !task.isComplete)
        .toList();

    void onTileTapped(index) {
      Provider.of<Providers>(context, listen: false)
          .toggleTaskCompletion(index);
    }

    void onDismissed(index) {
      Provider.of<Providers>(context, listen: false).deleteTask(index);
    }

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "List of incomplete task(s)",
            style: TextStyle(
                fontSize: 16, color: Colors.blue, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 3),
          const Text(
            "Slide to left or right to delete task",
            style: TextStyle(
              fontSize: 14,
              color: Colors.deepPurple,
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
                itemCount: todos.length,
                itemBuilder: (contexisCompletet, index) {
                  return Column(
                    children: [
                      tile(todos[index].id, todos[index].task,
                          todos[index].isComplete, onTileTapped, onDismissed),
                    ],
                  );
                }),
          )
        ],
      ),
    );
  }
}
