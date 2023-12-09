import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_flutter/class/todos.dart';
import 'package:sample_flutter/components/tile.dart';
import 'package:sample_flutter/providers/providers.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Todos> todos = Provider.of<Providers>(context, listen: true).todos;

    void onTileTapped(index) {
      Provider.of<Providers>(context, listen: false)
          .toggleTaskCompletion(index);
    }

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text("Todos page"),
          Expanded(
            child: ListView.builder(
                itemCount: todos.length,
                itemBuilder: (contexisCompletet, index) {
                  return Column(
                    children: [
                      tile(index, todos[index].task, todos[index].isComplete,
                          onTileTapped),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  );
                }),
          )
        ],
      ),
    );
  }
}
