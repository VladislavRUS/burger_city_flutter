import 'package:burger_city_flutter/components/text_button.dart';
import 'package:flutter/material.dart';

class TextButtonCheckbox extends StatelessWidget {
  String text;
  Function onTap;
  bool isActive;

  TextButtonCheckbox({this.text, this.onTap, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: this.onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Opacity(
              opacity: 0.66,
              child: Container(
                margin: EdgeInsets.only(right: 4),
                decoration: BoxDecoration(
                    color: isActive ? Colors.white : Colors.transparent,
                    borderRadius: BorderRadius.circular(9),
                    border: Border.fromBorderSide(
                        BorderSide(color: Colors.white, width: 2))),
                width: 18,
                height: 18,
              ),
            ),
            TextButton(text: this.text)
          ],
        ),
      ),
    );
  }
}
