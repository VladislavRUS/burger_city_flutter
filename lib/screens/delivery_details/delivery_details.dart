import 'package:burger_city_flutter/app_localizations.dart';
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

  List<SelectButtonOption> options = [
    SelectButtonOption(name: 'deliveryDetails.orderNow', value: 'now'),
    SelectButtonOption(name: 'deliveryDetails.orderInAdvance', value: 'advance')
  ];

  SelectButtonOption selectedOption;

  String translate(key) {
    return AppLocalizations.of(context).translate(key);
  }

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
                translate('deliveryDetails.toProceed')),
          ),
          buildSelectButton()
        ],
      ),
    );
  }

  Widget buildSelectButton() {
    List<SelectButtonOption> mappedOptions = options.map((option) {
      return SelectButtonOption(name: translate(option.name), value: option.value);
    }).toList();

    return SelectButton(mappedOptions, selectedOption, (option) {
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

    String addressText = store.order?.address?.title ?? translate('deliveryDetails.deliveryAddress');

    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(bottom: 20),
              child: buildTitleText(translate('deliveryDetails.deliveryAddress'))),
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
      dateTimeMsg = translate('deliveryDetails.deliveryDateAndTime');
    } else {
      var format = DateFormat(translate('deliveryDetails.deliveryDateAndTimeFormat'));
      dateTimeMsg = format.format(store.order.dateTime);
    }

    return AbsorbPointer(
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            buildTitleText(translate('deliveryDetails.deliveryDateAndTime')),
            Container(
                margin: EdgeInsets.only(bottom: 20),
                child: buildRegularText(translate('deliveryDetails.pleaseSelectDateAndTime'))),
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
      absorbing: selectedOption.value == 'now',
    );
  }

  Widget buildButton() {
    return Button(text: translate('deliveryDetails.proceed'), onTap: () {
      Navigator.of(context).pushNamed(Routes.ORDER);
    }, isDisabled: isProceedDisable(),);
  }

  bool isProceedDisable() {
    Store store = of(context);

    if (store.order.address == null || store.order.dateTime == null) {
      return true;
    }

    return false;
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
