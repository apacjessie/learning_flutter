import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:checkmate/class/todos.dart';
import 'package:checkmate/providers/providers.dart';

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
                  "Welcome $username 👋🏼",
                  style: const TextStyle(
                      color: Color(0xFFe74c3c),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1),
                ),
                const SizedBox(height: 3),
                const Text(
                  "Organize effortlessly and supercharge productivity. ",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Add, manage, and track tasks with ease. Your simple solution for a more organized and productive day.",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            )),
        const SizedBox(height: 20),
        _box("Your todo(s)", "You have $allTask task(s)"),
        const SizedBox(height: 14),
        _box("Your Completed todo(s)",
            "You have $completedTask completed task(s)"),
        const SizedBox(height: 14),
        _box("Your Incomplete todo(s)",
            "You have $incompleteTask incomplete task(s)"),
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
        color: Color(0xFFe74c3c),
        borderRadius: BorderRadius.all(Radius.circular(0)),
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
