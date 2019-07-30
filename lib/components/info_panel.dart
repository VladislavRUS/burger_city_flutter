import 'package:flutter/material.dart';

class InfoPanel extends StatelessWidget {
  final Widget child;
  final Function onTap;

  InfoPanel({this.child, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: <BoxShadow>[
        BoxShadow(
            color: Color.fromARGB(20, 0, 0, 0), spreadRadius: 8, blurRadius: 15)
      ]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Material(
          color: Colors.white,
          child: InkWell(
            onTap: onTap,
            child: Container(
              height: 52,
              padding: EdgeInsets.only(left: 22, right: 22),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
