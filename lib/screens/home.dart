import 'package:flutter/material.dart';

class BulletText {
  String text;
  BulletText(this.text);
}

List<BulletText> bullet = [
  BulletText("Todos: View all your todos in one place and create a task."),
  BulletText(
      "Complete Todos: Celebrate your achievements by clearing off completed tasks."),
  BulletText("Incomplete Todos: Focus on the tasks that still need attention."),
];

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.all(30),
      child: Column(children: [
        const Text("Welcome to TaskTracker",
            style:
                TextStyle(fontSize: 20, letterSpacing: 2, color: Colors.blue)),
        Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 18),
              child: Column(
                children: [
                  const Text(
                    "Get organized and boost your productivity with our simple and intuitive todo list.",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Quickly add and manage your tasks, and keep track of your progress effortlessly.",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Navigate through your todos easily with the following tabs:",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.only(left: 12, right: 12),
                    child: Column(
                      children: bullet
                          .expand((item) => [
                                Text(item.text,
                                    style: const TextStyle(fontSize: 14)),
                                const SizedBox(height: 8),
                              ])
                          .toList(),
                    ),
                  )
                ],
              ),
            ))
      ]),
    ));
  }
}
