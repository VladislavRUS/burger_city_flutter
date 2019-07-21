import 'package:burger_city_flutter/constants/app_colors.dart';
import 'package:flutter/material.dart';

class InfoPanel extends StatelessWidget {
  final String text;

  InfoPanel(this.text);

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
            onTap: () {},
            child: Container(
              height: 52,
              padding: EdgeInsets.only(left: 22, right: 22),
              child: Row(
                children: <Widget>[
                  Text(text,
                      style: (TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.MAIN_DARK_COLOR))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
