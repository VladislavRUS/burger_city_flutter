import 'package:burger_city_flutter/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RoundCheckmark extends StatelessWidget {
  final bool isSelected;

  RoundCheckmark({this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: isSelected
              ? AppColors.MAIN_COLOR
              : Color.fromARGB(51, 114, 124, 142),
          borderRadius: BorderRadius.circular(10)),
      width: 20,
      height: 20,
      child: Center(
          child: SvgPicture.asset(
        'assets/icons/checkmark.svg',
        color: isSelected ? Colors.white : Colors.black,
      )),
    );
  }
}
