import 'package:crud/screens/dashboard.dart';
import 'package:crud/screens/registration_screen.dart';
import 'package:crud/services/authentication_services.dart';
import 'package:flutter/material.dart';
import 'package:crud/constants.dart';

class LoginScreen extends StatefulWidget {
  static String id = "logIn_screen";
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _key = GlobalKey<FormState>();
  final AuthenticationServices _auth = AuthenticationServices();

  TextEditingController _emailContoller = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
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
            // key: _key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Login',
                  style: kHeadingStyle,
                ),
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      TextFormField(
                        controller: _emailContoller,
                        validator: (value) {
                          var v = value;
                          if (v!.isEmpty) {
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
                          var v = value;
                          if (v!.isEmpty) {
                            return 'Password cannot be empty';
                          }
                        },
                        decoration: const InputDecoration(
                            labelText: 'Password', labelStyle: kLabelTextStyle),
                        style: kTextFieldStyle,
                      ),
                      const SizedBox(height: 5),
                      FlatButton(
                        onPressed: () {
                          Navigator.pushNamed(context, RegistrationScreen.id);
                        },
                        textColor: Colors.white,
                        child: const Text(
                          'Not registerd? Sign up',
                          style: kTextFieldStyle,
                        ),
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
                              signInUser();
                            },
                            child: const Text(
                              "Login",
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
