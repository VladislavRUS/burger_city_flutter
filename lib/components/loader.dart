import 'package:burger_city_flutter/constants/app_colors.dart';
import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(AppColors.LIGHT_GREY),
    );
  }
}
