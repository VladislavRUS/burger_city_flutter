import 'package:burger_city_flutter/app_localizations.dart';
import 'package:burger_city_flutter/components/button.dart';
import 'package:burger_city_flutter/components/custom_scaffold.dart';
import 'package:burger_city_flutter/components/leading_arrow_back.dart';
import 'package:burger_city_flutter/components/order_items.dart';
import 'package:burger_city_flutter/components/surprise_dialog.dart';
import 'package:burger_city_flutter/constants/app_colors.dart';
import 'package:burger_city_flutter/constants/app_pages.dart';
import 'package:burger_city_flutter/constants/routes.dart';
import 'package:burger_city_flutter/models/order.dart';
import 'package:burger_city_flutter/store/store.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';

class OrderScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return OrderScreenState();
  }
}

class OrderScreenState extends State<OrderScreen> {
  static Store of(context) => ScopedModel.of<Store>(context);
  bool isInitialized = false;
  Order currentOrder;
  int totalPrice;

  String translate(key) {
    return AppLocalizations.of(context).translate(key);
  }

  Widget buildReview() {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      color: Colors.black,
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            translate('order.reviewAndConfirm'),
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.w700),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                buildTitleText(
                  translate('order.summary'),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Row(
              children: <Widget>[
                buildTitleText(translate('order.subtotal')),
                Spacer(),
                buildValueText('$totalPrice \$')
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 40),
            child: Row(
              children: <Widget>[
                buildTitleText(translate('order.deliveryCharge')),
                Spacer(),
                buildValueText('50 \$')
              ],
            ),
          ),
          Row(
            children: <Widget>[
              buildTitleText(translate('order.total')),
              Spacer(),
              buildValueText('${totalPrice + 50} \$',
                  fontWeight: FontWeight.w700, fontSize: 20.0)
            ],
          )
        ],
      ),
    );
  }

  Widget buildTitleText(String text) {
    return Text(text,
        style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: AppColors.MAIN_COLOR));
  }

  Widget buildValueText(String text,
      {fontWeight: FontWeight.w600, fontSize: 15.0}) {
    return Text(text,
        style: TextStyle(
            fontSize: fontSize, fontWeight: fontWeight, color: Colors.white));
  }

  Widget buildAddress() {
    var formatter = DateFormat(translate('order.dateTimeFormat'));
    String dateTime =
        currentOrder.isInAdvance ? formatter.format(currentOrder.dateTime) : '';

    return Container(
      margin: EdgeInsets.only(bottom: 25),
      padding: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
      color: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(bottom: 5),
              child: buildValueText(translate('order.deliveringBy'),
                  fontSize: 16.0, fontWeight: FontWeight.w700)),
          Container(
              margin: EdgeInsets.only(bottom: 5),
              child: buildTitleText(dateTime)),
          buildValueText(currentOrder.addressDescription.title),
        ],
      ),
    );
  }

  onConfirm() {
    Store store = of(context);
    store.confirmOrder();
    currentOrder = store.confirmedOrder;

    showDialog(
        context: context,
        builder: (context) => SurpriseDialog(
            'assets/drinks/cola_1.png', translate('order.prize')));
  }

  onTrack() {
    Navigator.of(context).pushReplacementNamed(Routes.APP,
        arguments: {"activePage": AppPages.TRACK_ORDERS});
  }

  Widget buildOrderItems() {
    return OrderItems(currentOrder, translate);
  }

  Widget buildBottomButton() {
    Store store = of(context);
    Widget childButton;

    if (store.confirmedOrder != null) {
      childButton = Button(text: translate('order.trackOrder'), onTap: onTrack);
    } else {
      childButton = Button(
        text: translate('order.confirm'),
        onTap: onConfirm,
      );
    }

    return Positioned(
      bottom: 20,
      left: 20,
      right: 20,
      child: AnimatedSwitcher(
          duration: Duration(
            milliseconds: 200,
          ),
          child: childButton),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!isInitialized) {
      init();
    }
  }

  init() {
    Store store = of(context);
    currentOrder = store.order;
    totalPrice = store.getTotalPrice();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      showCartButton: false,
      leading: LeadingIconBack(),
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 60),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    buildReview(),
                    buildAddress(),
                    buildOrderItems(),
                  ]),
            ),
          ),
          buildBottomButton()
        ],
      ),
    );
  }
}
