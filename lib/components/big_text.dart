import 'package:flutter/material.dart';

class BigText extends StatelessWidget {
  final String text;

  BigText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      this.text,
      style: TextStyle(
          height: 1.05,
          fontSize: 31,
          color: Colors.white,
          fontWeight: FontWeight.w700),
    );
  }
}
