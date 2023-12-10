import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_flutter/providers/providers.dart';
import '../components/textfield.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  RegistrationScreenState createState() => RegistrationScreenState();
}

class RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool confirmPwError = false;
  bool emptyInput = false;

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
            child: SingleChildScrollView(
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 120, horizontal: 50),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 80,
                      ),
                      const SizedBox(height: 30),
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Start organizing your tasks! Sign up now to create your TaskTracker account.',
                            style:
                                TextStyle(fontSize: 14.5, color: Colors.white),
                          )),
                      const SizedBox(height: 20),
                      textfield(usernameController, "Username"),
                      const SizedBox(height: 20),
                      textfield(passwordController, "Password", obscure: true),
                      const SizedBox(height: 20),
                      textfield(confirmPasswordController, "Confirm Password",
                          obscure: true),
                      const SizedBox(height: 10),
                      if (emptyInput)
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "All inputs are required",
                            style: TextStyle(
                                color: Colors.deepPurple, fontSize: 15),
                          ),
                        ),
                      if (confirmPwError)
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Confirm password does not match",
                            style: TextStyle(
                                color: Colors.deepPurple, fontSize: 15),
                          ),
                        ),
                      SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 12.0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(6),
                                  backgroundColor: Colors.white,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5)))),
                              onPressed: () {
                                String username =
                                    usernameController.text.trim();
                                String password =
                                    passwordController.text.trim();
                                String confirmPw =
                                    confirmPasswordController.text.trim();
                                setState(() {
                                  emptyInput = false;
                                  confirmPwError = false;
                                });
                                if (password != confirmPw) {
                                  return setState(() {
                                    confirmPwError = true;
                                  });
                                }
                                if (username.isEmpty ||
                                    password.isEmpty ||
                                    confirmPw.isEmpty) {
                                  return setState(() {
                                    emptyInput = true;
                                  });
                                }
                                Provider.of<Providers>(context, listen: false)
                                    .register(username, password);
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'Register',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                          )),
                      const SizedBox(
                        height: 15,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: const ButtonStyle(
                                padding:
                                    MaterialStatePropertyAll(EdgeInsets.all(0)),
                                shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(3.5))))),
                            child: const Text(
                              "Return to login",
                              style: TextStyle(color: Colors.white),
                            )),
                      )
                    ],
                  )),
            ),
          )),
    );
  }
}
