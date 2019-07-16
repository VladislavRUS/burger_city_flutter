import 'package:burger_city_flutter/constants/app_colors.dart';
import 'package:flutter/material.dart';

import 'custom_chip.dart';

class QuantityButton extends StatelessWidget {
  final String value;
  Function onDec;
  Function onInc;

  QuantityButton(this.value, this.onDec, this.onInc);

  Widget buildChipButton(String text, Function onTap) {
    return Material(
      child: InkWell(
        onTap: onTap,
        child: CustomChip(
            child: Text(
          text,
          style: TextStyle(fontSize: 14, color: AppColors.DARK_ICON_COLOR),
        )),
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
        children: <Widget>[
          buildChipButton('-', onDec),
          Text(
            value,
            style: TextStyle(fontSize: 14, color: AppColors.DARK_ICON_COLOR),
          ),
          buildChipButton('+', onInc),
        ],
      ),
    );
  }
}
