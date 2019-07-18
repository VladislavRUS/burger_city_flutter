import 'package:burger_city_flutter/constants/app_colors.dart';
import 'package:flutter/material.dart';

class LeadingIconBack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        color: AppColors.MAIN_COLOR,
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.of(context).pop();
        });
  }
}
