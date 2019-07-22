import 'package:burger_city_flutter/components/custom_scaffold.dart';
import 'package:burger_city_flutter/components/leading_arrow_back.dart';
import 'package:flutter/material.dart';

class DateAndTimeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DateAndTimeScreenScreen();
  }
}

class DateAndTimeScreenScreen extends State<DateAndTimeScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      leading: LeadingIconBack(),
      showCartButton: false,
      body: Stack(
        children: <Widget>[

        ],
      ),
    );
  }
}