import 'package:flutter/material.dart';

class SignInButton extends StatelessWidget {
  SignInButton(this.id, this.displayText, this.bgColor, this.textColor);

  // final Function operation;
  final String id;
  final String displayText;
  final Color bgColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: bgColor,
      borderRadius: BorderRadius.circular(30.0),
      elevation: 5.0,
      child: MaterialButton(
        onPressed: () {
          Navigator.pushNamed(context, id);
        },
        minWidth: 200.0,
        height: 42.0,
        child: Text(
          displayText,
          style: TextStyle(
            fontFamily: "Spartan MB",
            color: textColor,
          ),
        ),
      ),
    );
  }
}
