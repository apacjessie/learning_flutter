import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_flutter/components/textfield.dart';
import 'package:sample_flutter/providers/providers.dart';
import 'package:sample_flutter/screens/complete_todos.dart';
import 'package:sample_flutter/screens/incomplete_todos.dart';
import 'package:sample_flutter/screens/todos.dart';
import './screens/home.dart';
import './components/navigation.dart';
import 'screens/login.dart';
import 'dart:math';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Providers(),
      child: const MyApp(),
    ),
  );
}

String generateRandomId({int length = 16}) {
  final random = Random();
  const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';

  return String.fromCharCodes(List.generate(
      length, (index) => chars.codeUnitAt(random.nextInt(chars.length))));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  int _selectedIndex = 0;
  TextEditingController taskName = TextEditingController();

  static final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    const TodoScreen(),
    const CompleteTodos(),
    const IncompleteTodos()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onLoggedOut() {
    Provider.of<Providers>(context, listen: false).logout();
  }

  void modal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(height: 10),
              const Text(
                "Add task",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2),
              ),
              const SizedBox(
                height: 30,
              ),
              textfield(taskName, "Task name"),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    String task = taskName.text;
                    if (task.trim() == '') return;
                    Provider.of<Providers>(context, listen: false)
                        .addTask(task);
                    taskName.clear();
                    Navigator.pop(context);
                  },
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.blue),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5))))),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.create,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Create new task",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ))
            ]),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TaskTracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Consumer<Providers>(
        builder: (context, authProvider, child) {
          return authProvider.isLoggedIn
              ? Scaffold(
                  appBar: AppBar(
                    title: const Text(
                      'TaskTracker',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2),
                    ),
                    backgroundColor: Colors.blue,
                  ),
                  body: _widgetOptions.elementAt(_selectedIndex),
                  floatingActionButton: FloatingActionButton(
                    onPressed: () {
                      modal(context);
                    },
                    backgroundColor: Colors.blue,
                    shape: const CircleBorder(),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                  bottomNavigationBar: navigationbar(
                      _selectedIndex, _onItemTapped, _onLoggedOut))
              : const LoginScreen();
        },
      ),
    );
  }
}
