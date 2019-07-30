import 'package:burger_city_flutter/components/button.dart';
import 'package:burger_city_flutter/components/custom_scaffold.dart';
import 'package:burger_city_flutter/components/info_panel.dart';
import 'package:burger_city_flutter/components/info_panel_text.dart';
import 'package:burger_city_flutter/components/leading_arrow_back.dart';
import 'package:burger_city_flutter/components/select_button.dart';
import 'package:burger_city_flutter/constants/app_colors.dart';
import 'package:burger_city_flutter/constants/routes.dart';
import 'package:burger_city_flutter/store/store.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';

class DeliveryDetailsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DeliveryDetailsScreenState();
  }
}

class DeliveryDetailsScreenState extends State<DeliveryDetailsScreen>
    with SingleTickerProviderStateMixin {
  static Store of(context) => ScopedModel.of<Store>(context);
  AnimationController controller;
  Animation<double> animation;

  final List<SelectButtonOption> options = [
    SelectButtonOption(name: 'Order now', value: 'now'),
    SelectButtonOption(name: 'Order in advance', value: 'advance')
  ];

  SelectButtonOption selectedOption;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(duration: Duration(milliseconds: 150), vsync: this);
    animation = Tween(begin: 0.0, end: 1.0)
        .chain(CurveTween(curve: Curves.ease))
        .animate(controller);

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

      if (controller.isCompleted) {
        controller.reverse();
      } else {
        controller.forward();
      }
    });
  }

  Widget buildAddress() {
    Store store = of(context);

    String addressText = store.order.address ?? 'Delivery Address';

    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(bottom: 20),
              child: buildTitleText('Delivery Address')),
          InfoPanel(
            child: Row(
              children: <Widget>[
                Expanded(child: InfoPanelText(addressText)),
                Icon(
                  Icons.edit,
                  color: AppColors.DARK_ICON_COLOR,
                  size: 18,
                )
              ],
            ),
            onTap: () {
              Navigator.of(context).pushNamed(Routes.ADDRESS);
            },
          )
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
    Store store = of(context);
    String dateTimeMsg;

    if (store.order.dateTime == null) {
      dateTimeMsg = 'Delivery Date & Time';
    } else {
      var format = DateFormat('dd.MM.yyyy HH:mm');
      dateTimeMsg = format.format(store.order.dateTime);
    }

    return AbsorbPointer(
      absorbing: selectedOption.value == 'now',
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            buildTitleText('Delivery Date & Time'),
            Container(
                margin: EdgeInsets.only(bottom: 20),
                child: buildRegularText('Please select delivery Date & Time')),
            InfoPanel(
                child: Row(
                  children: <Widget>[
                    InfoPanelText(dateTimeMsg),
                    Spacer(),
                    Icon(
                      Icons.edit,
                      color: AppColors.DARK_ICON_COLOR,
                      size: 18,
                    )
                  ],
                ),
                onTap: () {
                  Navigator.of(context).pushNamed(Routes.DATE_AND_TIME);
                })
          ],
        ),
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
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  buildOrderType(),
                  buildAddress(),
                  FadeTransition(child: buildDateAndTime(), opacity: animation),
                ].where((widget) => widget != null).toList(),
              ),
            ),
          ),
          Positioned(bottom: 20, left: 20, right: 20, child: buildButton())
        ],
      ),
    );
  }
}
