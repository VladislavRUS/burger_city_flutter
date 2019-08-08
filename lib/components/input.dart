import 'package:burger_city_flutter/constants/app_colors.dart';
import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  IconData iconData;
  String placeholder;
  bool isObscured;
  Function onChanged;
  bool autofocus;

  Input(
      {this.iconData,
      this.placeholder,
      this.isObscured = false,
      this.autofocus = false,
      this.onChanged});

  onTextChanged(String text) {
    if (onChanged != null) {
      onChanged(text);
    }
  }

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
          autofocus: this.autofocus,
          onChanged: onTextChanged,
          obscureText: this.isObscured,
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
    return Container(
      decoration: BoxDecoration(boxShadow: <BoxShadow>[
        BoxShadow(
            color: Color.fromARGB(20, 0, 0, 0),
            blurRadius: 5,
            spreadRadius: 1,
            offset: Offset(0, 2))
      ]),
      child: ClipRRect(
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
      ),
    );
  }
}
