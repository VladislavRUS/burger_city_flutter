import 'package:burger_city_flutter/constants/app_colors.dart';
import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final IconData iconData;
  final String placeholder;

  Input({this.iconData, this.placeholder});

  Widget buildIcon() {
    if (iconData == null) {
      return null;
    }

    return Container(
        margin: EdgeInsets.only(left: 20),
        child: Icon(
          iconData,
          color: AppColors.LIGHT_GREY,
        ));
  }

  Widget buildTextField() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(left: 15),
        child: TextField(
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.LIGHT_GREY),
          decoration: InputDecoration(
              hintText: placeholder,
              hintStyle: TextStyle(color: AppColors.LIGHT_GREY),
              border: InputBorder.none),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: Container(
        height: 48,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[buildIcon(), buildTextField()]
              .where((widget) => widget != null)
              .toList(),
        ),
      ),
    );
  }
}
