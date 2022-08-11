import 'package:flutter/material.dart';
import 'package:crud/services/authentication_services.dart';
import 'package:crud/screens/dashboard.dart';
import 'package:crud/constants.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = "registration_screen";
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _key = GlobalKey<FormState>();

  final AuthenticationServices _auth = AuthenticationServices();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailContoller = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  void showDialogue() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.deepPurpleAccent.shade200,
            title: Text(
              "Hii ${_nameController.text}, enter your employee ID and department by clicking on the 🖍 button.",
              style: kTextFieldStyle,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, DashboardScreen.id);
                },
                child: const Text(
                  "Ok",
                  style: kLabelTextStyle,
                ),
              ),
            ],
          );
        });
  }

  void createUser() async {
    dynamic result = await _auth.createNewUser(
        _nameController.text, _emailContoller.text, _passwordController.text);
    if (result == null) {
      print("Email not found");
    } else {
      print(
        result.toString(),
      );
      _nameController.clear();
      _emailContoller.clear();
      _passwordController.clear();
      Navigator.pushNamed(context, DashboardScreen.id);
    }
  }

  void signInUser() async {
    dynamic result =
        await _auth.loginUser(_emailContoller.text, _passwordController.text);
    print(result);
    if (result == null) {
      print("Sign in error.Could not log in.");
    } else {
      _emailContoller.clear();
      _passwordController.clear();
      print("Sign in done.");
      Navigator.pushNamed(context, DashboardScreen.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.deepPurple,
        child: Center(
          child: Form(
            key: _key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Register',
                  style: kHeadingStyle,
                ),
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Name cannot be empty';
                          }
                        },
                        decoration: const InputDecoration(
                          labelText: 'Name',
                          labelStyle: kLabelTextStyle,
                        ),
                        style: kTextFieldStyle,
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        controller: _emailContoller,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Email cannot be empty';
                          }
                        },
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          labelStyle: kLabelTextStyle,
                        ),
                        style: kTextFieldStyle,
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Password cannot be empty';
                          }
                        },
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          labelStyle: kLabelTextStyle,
                        ),
                        style: kTextFieldStyle,
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.all(10)),
                              elevation: MaterialStateProperty.all(10),
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.deepPurpleAccent),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                            ),
                            onPressed: () {
                              if (_key.currentState!.validate()) {
                                createUser();
                                signInUser();
                                showDialogue();
                              }
                              // Navigator.pushNamed(context, DashboardScreen.id);
                            },
                            child: const Text(
                              "Sign Up",
                              style: kLabelTextStyle,
                            ),
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.all(10)),
                              elevation: MaterialStateProperty.all(10),
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.deepPurpleAccent),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Cancel",
                              style: kLabelTextStyle,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
