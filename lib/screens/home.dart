import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_flutter/class/todos.dart';
import 'package:sample_flutter/providers/providers.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    String? username = Provider.of<Providers>(context, listen: false).username;
    List<Todos> todos = Provider.of<Providers>(context, listen: true).todos;
    int allTask = todos.length;
    int completedTask = todos.where((task) => task.isComplete).toList().length;
    int incompleteTask =
        todos.where((task) => !task.isComplete).toList().length;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Align(
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hello $username 👋",
                  style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1),
                ),
                const SizedBox(height: 3),
                const Text(
                  "Get organized and boost your productivity with our simple and intuitive todo list.",
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Quickly add and manage your tasks, and keep track of your progress effortlessly.",
                  style: TextStyle(fontSize: 14),
                ),
              ],
            )),
        const SizedBox(height: 20),
        _box("All tasks", "You have $allTask task(s)"),
        const SizedBox(height: 14),
        _box("Completed tasks", "You have $completedTask completed task(s)"),
        const SizedBox(height: 14),
        _box("Incomplete tasks", "You have $incompleteTask incomplete task(s)"),
      ]),
    );
  }
}

Widget _box(String label, String hinter) {
  Widget text(String text, FontWeight fontWeight, double fontSize,
      {Color fontColor = Colors.white}) {
    return Text(text,
        style: TextStyle(
            fontSize: fontSize, fontWeight: fontWeight, color: fontColor));
  }

  return Container(
    padding: const EdgeInsets.all(15),
    decoration: const BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.all(Radius.circular(5)),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 3))
        ]),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        text(label, FontWeight.bold, 18),
        Align(
            alignment: Alignment.topLeft,
            child: text(hinter, FontWeight.normal, 15)),
      ],
    ),
  );
}
