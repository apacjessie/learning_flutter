import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_flutter/class/todos.dart';
import 'package:sample_flutter/providers/providers.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Todos> todos = Provider.of<Providers>(context, listen: true).todos;
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
                      CheckboxListTile(
                        value: todos[index].isComplete,
                        onChanged: (value) {
                          Provider.of<Providers>(context, listen: false)
                              .toggleTaskCompletion(index);
                        },
                        activeColor: Colors.blue,
                        checkColor: Colors.white,
                        tileColor: todos[index].isComplete
                            ? Colors.blue.withOpacity(0.8)
                            : Colors.red.withOpacity(0.8),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: todos[index].isComplete
                                ? Colors.blue
                                : Colors.black,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        secondary: todos[index].isComplete
                            ? const Icon(Icons.check, color: Colors.white)
                            : const Icon(Icons.close),
                        title: Text(
                          todos[index].task,
                          style: TextStyle(
                              color: todos[index].isComplete
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      ),
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
