import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:checkmate/class/todos.dart';
import 'package:checkmate/components/tile.dart';
import 'package:checkmate/providers/providers.dart';

class CompleteTodos extends StatelessWidget {
  const CompleteTodos({super.key});

  @override
  Widget build(BuildContext context) {
    List<Todos> todos = Provider.of<Providers>(context, listen: true)
        .todos
        .where((task) => task.isComplete)
        .toList();

    void onTileTapped(id) {
      Provider.of<Providers>(context, listen: false).toggleTaskCompletion(id);
    }

    void onDismissed(id) {
      Provider.of<Providers>(context, listen: false).deleteTask(id);
    }

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "List of completed task(s)",
            style: TextStyle(
                fontSize: 16,
                color: Color(0xFFe74c3c),
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 3),
          const Text(
            "Slide to left or right to delete task",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.topLeft,
            child: IntrinsicWidth(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, shape: const LinearBorder()),
                onPressed: () {
                  Provider.of<Providers>(context, listen: false)
                      .clearCompleteTask();
                },
                child: const Text(
                  "Clear",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),
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
