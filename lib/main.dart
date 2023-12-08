import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_flutter/screens/complete_todos.dart';
import 'package:sample_flutter/screens/incomplete_todos.dart';
import 'package:sample_flutter/screens/todos.dart';
import './screens/home.dart';
import './components/navigation.dart';
import 'screens/login.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: const MyApp(),
    ),
  );
}

class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  void login() {
    _isLoggedIn = true;
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    notifyListeners();
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

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
    Provider.of<AuthProvider>(context, listen: false).logout();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TaskTracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Consumer<AuthProvider>(
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
                  bottomNavigationBar: navigationbar(
                      _selectedIndex, _onItemTapped, _onLoggedOut))
              : const LoginScreen();
        },
      ),
    );
  }
}
