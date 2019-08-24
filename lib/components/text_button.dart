import 'package:flutter/material.dart';

class TextButton extends StatelessWidget {
  String text;
  Function onTap;
  Color textColor;

  TextButton(this.text,
      {this.textColor = const Color.fromARGB(168, 255, 255, 255), this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: onTap,
            child: Container(
              child: Text(
                this.text,
                style: TextStyle(
                    color: this.textColor,
                    fontSize: 12,
                    height: 1.16,
                    fontWeight: FontWeight.w600),
              ),
            )));
  }
}
