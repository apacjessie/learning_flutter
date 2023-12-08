import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import '../class//user.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool errorCredential = false;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blue,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Welcome back 👋',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                      color: Colors.white),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: usernameController,
                  cursorColor: Colors.white,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    floatingLabelStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: passwordController,
                  cursorColor: Colors.white,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    floatingLabelStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 10),
                if (errorCredential)
                  const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: Row(
                            children: [
                              Icon(Icons.error_rounded,
                                  color: Colors.deepPurple),
                              SizedBox(width: 10),
                              Text(
                                'Account does not exist',
                                style: TextStyle(
                                    color: Colors.deepPurple, fontSize: 15),
                              )
                            ],
                          ))),
                SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                        onPressed: () {
                          User user = User("apacjessie", "password");
                          String username = usernameController.text.trim();
                          String password = passwordController.text.trim();
                          if (username == user.username &&
                              password == user.password) {
                            Provider.of<AuthProvider>(context, listen: false)
                                .login();
                            setState(() {
                              errorCredential = false;
                            });
                          } else {
                            setState(() {
                              errorCredential = true;
                            });
                          }
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
