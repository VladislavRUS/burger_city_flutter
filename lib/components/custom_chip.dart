import 'package:flutter/material.dart';

class CustomChip extends StatelessWidget {
  Widget child;

  CustomChip({this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 18,
      height: 18,
      decoration: BoxDecoration(
          color: Color.fromARGB(20, 114, 124, 142),
          borderRadius: BorderRadius.circular(9)),
      child: Center(
        child: child,
      ),
    );
  }
}
