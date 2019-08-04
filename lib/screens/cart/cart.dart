import 'package:burger_city_flutter/components/button.dart';
import 'package:burger_city_flutter/components/custom_scaffold.dart';
import 'package:burger_city_flutter/components/input.dart';
import 'package:burger_city_flutter/components/leading_arrow_back.dart';
import 'package:burger_city_flutter/components/order_items.dart';
import 'package:burger_city_flutter/constants/app_colors.dart';
import 'package:burger_city_flutter/constants/durations.dart';
import 'package:burger_city_flutter/constants/routes.dart';
import 'package:burger_city_flutter/models/burger_order.dart';
import 'package:burger_city_flutter/store/store.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class CartScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CartScreenState();
  }
}

class CartScreenState extends State<CartScreen> {
  static Store of(context) => ScopedModel.of(context, rebuildOnChange: true);

  bool isLoading = false;

  Widget buildHeader() {
    Store store = of(context);

    int length = store.order.burgerOrders.length;

    return Container(
      height: 90,
      color: Colors.black,
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 20),
            child: Text(
              'Sub Total ($length ${length > 1 ? 'items' : 'item'})',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
            ),
          ),
          Spacer(),
          Container(
            margin: EdgeInsets.only(right: 14),
            child: Text(
              '${store.getTotalPrice()} \$',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.MAIN_COLOR),
            ),
          )
        ],
      ),
    );
  }

  Widget titleText(String text) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: AppColors.MAIN_DARK_COLOR),
    );
  }

  Widget buildOrders() {
    Store store = of(context);

    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 18),
            child: titleText('Includes'),
          ),
          OrderItems(
            order: store.order,
          )
        ],
      ),
    );
  }

  Widget buildPromoCode() {
    return Container(
      decoration: BoxDecoration(boxShadow: <BoxShadow>[
        BoxShadow(
            color: Color.fromARGB(20, 0, 0, 0), spreadRadius: 8, blurRadius: 15)
      ]),
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(bottom: 14),
              child: titleText('Promo code')),
          Input(
            placeholder: 'Enter promo code',
          ),
        ],
      ),
    );
  }

  onCheckout() async {
    Store store = of(context);
    var now = DateTime.now();
    store.setOrderDate(now);
    store.setOrderTime(TimeOfDay(hour: now.hour + 1, minute: now.minute));
    Navigator.of(context).pushNamed(Routes.DELIVERY_DETAILS);
  }

  showLoader() {
    setState(() {
      isLoading = true;
    });
  }

  hideLoader() {
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;

    return CustomScaffold(
      leading: LeadingIconBack(),
      showCartButton: false,
      body: Stack(
        children: <Widget>[
          Positioned.fill(
              child: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: isKeyboardVisible ? 20 : 90),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                buildHeader(),
                buildOrders(),
                buildPromoCode()
              ],
            ),
          )),
          isKeyboardVisible
              ? null
              : Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: Container(
                    child: Button(
                      isLoading: isLoading,
                      onTap: onCheckout,
                      text: 'Checkout',
                    ),
                  ),
                )
        ].where((widget) => widget != null).toList(),
      ),
    );
  }
}
