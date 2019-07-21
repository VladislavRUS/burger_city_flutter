import 'package:burger_city_flutter/components/button.dart';
import 'package:burger_city_flutter/components/custom_scaffold.dart';
import 'package:burger_city_flutter/components/info_panel.dart';
import 'package:burger_city_flutter/components/leading_arrow_back.dart';
import 'package:burger_city_flutter/components/select_button.dart';
import 'package:burger_city_flutter/constants/app_colors.dart';
import 'package:flutter/material.dart';

class DeliveryDetails extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DeliveryDetailsState();
  }
}

class DeliveryDetailsState extends State<DeliveryDetails> {
  final List<SelectButtonOption> options = [
    SelectButtonOption(name: 'Order now', value: 'now'),
    SelectButtonOption(name: 'Order in advance', value: 'advance')
  ];

  SelectButtonOption selectedOption;

  @override
  void initState() {
    super.initState();

    selectedOption = options[0];
  }

  Widget buildOrderType() {
    return Container(
      margin: EdgeInsets.only(bottom: 27),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: buildRegularText(
                'To proceed , please confirm your delivery details'),
          ),
          buildSelectButton()
        ],
      ),
    );
  }

  Widget buildSelectButton() {
    return SelectButton(options, selectedOption, (option) {
      setState(() {
        selectedOption = option;
      });
    });
  }

  Widget buildAddress() {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(bottom: 20),
              child: buildTitleText('Delivery Address')),
          InfoPanel('No. 02, 6th Lane, Colombo 03')
        ],
      ),
    );
  }

  Widget buildTitleText(String text) {
    return buildText(text, 20, FontWeight.w700);
  }

  Widget buildRegularText(String text) {
    return buildText(text, 15, FontWeight.w600);
  }

  Widget buildText(String text, double fontSize, FontWeight fontWeight) {
    return Text(text,
        style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: AppColors.MAIN_DARK_COLOR));
  }

  Widget buildDateAndTime() {
    if (this.selectedOption.value == 'now') {
      return null;
    }

    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          buildTitleText('Delivery Date & Time'),
          Container(
              margin: EdgeInsets.only(bottom: 20),
              child: buildRegularText('Please select delivary Date & Time')),
          InfoPanel('Delivery Date & Time')
        ],
      ),
    );
  }

  Widget buildButton() {
    return Button(text: 'Proceed to Order');
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      leading: LeadingIconBack(),
      showCartButton: false,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildOrderType(),
            buildAddress(),
            buildDateAndTime(),
            buildButton()
          ].where((widget) => widget != null).toList(),
        ),
      ),
    );
  }
}
