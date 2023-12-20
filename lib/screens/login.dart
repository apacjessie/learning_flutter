import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_flutter/components/textfield.dart';
import 'package:sample_flutter/providers/providers.dart';
import 'package:sample_flutter/screens/registration.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
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
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.lock,
                  color: Colors.white,
                  size: 80,
                ),
                const SizedBox(height: 30),
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Welcome back you\'ve been missed.',
                      style: TextStyle(fontSize: 14.5, color: Colors.white),
                    )),
                const SizedBox(height: 20),
                textfield(usernameController, "Username"),
                const SizedBox(height: 20),
                textfield(passwordController, "Password", obscure: true),
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
                            padding: const EdgeInsets.all(6),
                            backgroundColor: Colors.white,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)))),
                        onPressed: () async {
                          String username = usernameController.text.trim();
                          String password = passwordController.text.trim();
                          bool isValid =
                              Provider.of<Providers>(context, listen: false)
                                  .isCredentialValid(username, password);

                          if (isValid) {
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
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    )),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          errorCredential = false;
                        });
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const RegistrationScreen()));
                      },
                      style: const ButtonStyle(
                          padding: MaterialStatePropertyAll(EdgeInsets.all(0)),
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(3.5))))),
                      child: const Text(
                        "No account? register now",
                        style: TextStyle(color: Colors.white),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
