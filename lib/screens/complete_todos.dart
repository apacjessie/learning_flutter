import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_flutter/class/todos.dart';
import 'package:sample_flutter/components/tile.dart';
import 'package:sample_flutter/providers/providers.dart';

class CompleteTodos extends StatelessWidget {
  const CompleteTodos({super.key});

  @override
  Widget build(BuildContext context) {
    List<Todos> todos = Provider.of<Providers>(context, listen: true)
        .userTodos
        .where((task) => task.isComplete)
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
            "List of completed task(s)",
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
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.topLeft,
            child: IntrinsicWidth(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red, shape: const LinearBorder()),
                  onPressed: () {
                    Provider.of<Providers>(context, listen: false)
                        .clearAllComplete();
                  },
                  child: const Row(
                    children: [
                      Icon(
                        Icons.clear_all,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Clear all",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  )),
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
