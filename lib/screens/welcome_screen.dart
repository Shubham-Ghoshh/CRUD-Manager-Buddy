import 'package:flutter/material.dart';
import 'package:crud/screens/login_screen.dart';
import 'package:crud/screens/registration_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:crud/components/buttons.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = "welcome_screen";

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  double heightAnimation = 0;
  Color bgAnimationColor = Colors.white;
  @override
  void initState() {
    super.initState();
    AnimationController controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    Animation animation =
        ColorTween(begin: Colors.white, end: Colors.blueAccent)
            .animate(controller);

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage("images/back.png"),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.white.withOpacity(.8),
            BlendMode.dstATop,
          ),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Center(
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(40, 0, 0, 10),
                        child: AnimatedTextKit(
                          animatedTexts: [
                            ColorizeAnimatedText(
                              'Manage Buddy',
                              colors: [
                                Colors.white,
                                Colors.deepPurple.shade900,
                              ],
                              textStyle: const TextStyle(
                                fontSize: 35.0,
                                fontWeight: FontWeight.w900,
                                color: Colors.black54,
                                fontFamily: "Spartan MB",
                              ),
                              speed: const Duration(milliseconds: 60),
                            ),
                          ],
                        )),
                  ),
                ],
              ),
              const SizedBox(
                height: 48.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: SignInButton(
                  RegistrationScreen.id,
                  "Register",
                  Colors.deepPurpleAccent,
                  Colors.black54,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: SignInButton(
                  LoginScreen.id,
                  "Log In",
                  Colors.deepPurpleAccent,
                  Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
