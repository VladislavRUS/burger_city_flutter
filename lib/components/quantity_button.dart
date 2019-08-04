import 'package:burger_city_flutter/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'custom_chip.dart';

class QuantityButton extends StatelessWidget {
  final String value;
  Function onDec;
  Function onInc;

  QuantityButton(this.value, this.onDec, this.onInc);

  Widget buildChipButton(SvgPicture svgPicture, Function onTap) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Material(
        color: Color.fromARGB(51, 114, 124, 142),
        child: InkWell(
          onTap: onTap,
          child: Container(
            width: 20,
            height: 20,
            child: Center(
              child: svgPicture,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: <BoxShadow>[
        BoxShadow(
            color: Color.fromARGB(10, 0, 0, 0),
            blurRadius: 5,
            spreadRadius: 1,
            offset: Offset(0, 2))
      ], color: Colors.white, borderRadius: BorderRadius.circular(6)),
      height: 48,
      padding: EdgeInsets.only(left: 14, right: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          buildChipButton(
              SvgPicture.asset(
                'assets/icons/minus.svg',
                color: AppColors.DARK_ICON_COLOR,
              ),
              onDec),
          Text(
            value,
            style: TextStyle(fontSize: 14, color: AppColors.DARK_ICON_COLOR),
          ),
          buildChipButton(
              SvgPicture.asset(
                'assets/icons/plus.svg',
                width: 10,
                height: 10,
                color: AppColors.DARK_ICON_COLOR,
              ),
              onInc),
        ],
      ),
    );
  }
}
