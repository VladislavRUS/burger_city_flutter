import 'package:burger_city_flutter/constants/app_colors.dart';
import 'package:flutter/material.dart';

class InfoPanelText extends StatelessWidget {
  final String text;

  InfoPanelText(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 10),
      child: Text(
        text,
        overflow: TextOverflow.fade,
        softWrap: false,
        style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: AppColors.MAIN_DARK_COLOR),
      ),
    );
  }
}
