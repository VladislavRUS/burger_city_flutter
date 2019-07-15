import 'package:burger_city_flutter/constants/app_colors.dart';
import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  final String text;

  TitleText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      this.text,
      style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: AppColors.MAIN_DARK_COLOR),
    );
  }
}
