import 'package:burger_city_flutter/app_localizations.dart';
import 'package:burger_city_flutter/components/button.dart';
import 'package:burger_city_flutter/components/custom_scaffold.dart';
import 'package:burger_city_flutter/components/input.dart';
import 'package:burger_city_flutter/components/leading_arrow_back.dart';
import 'package:burger_city_flutter/components/loader.dart';
import 'package:burger_city_flutter/components/order_items.dart';
import 'package:burger_city_flutter/components/title_text.dart';
import 'package:burger_city_flutter/constants/app_colors.dart';
import 'package:burger_city_flutter/constants/routes.dart';
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
  bool isInitialized = false;
  bool cartHasProducts = false;

  String translate(key) {
    return AppLocalizations.of(context).translate(key);
  }

  Widget buildHeader() {
    Store store = of(context);

    return Container(
      height: 90,
      color: Colors.black,
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 20),
            child: Text(
              translate('cart.subTotal'),
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
            child: titleText(translate('cart.includes')),
          ),
          OrderItems(
            store.order,
            translate,
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
              child: titleText(translate('cart.promoCode'))),
          Input(
            placeholder: translate('cart.enterPromoCode'),
          ),
        ],
      ),
    );
  }

  onCheckout() async {
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isInitialized) {
      init();
    }
  }

  init() {
    Store store = of(context);

    cartHasProducts = store.order.productOrders.length > 0;

    setState(() {
      isInitialized = true;
    });
  }

  Widget buildEmptyPlaceholder() {
    return Center(child: TitleText(translate('cart.empty')));
  }

  Widget buildBody() {
    if (!isInitialized) {
      return Center(child: Loader());
    }

    if (!cartHasProducts) {
      return buildEmptyPlaceholder();
    }

    var isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;

    return (Stack(
      children: <Widget>[
        Positioned.fill(
            child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: isKeyboardVisible ? 20 : 90),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[buildHeader(), buildOrders(), buildPromoCode()],
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
                    text: translate('cart.checkout'),
                  ),
                ),
              )
      ].where((widget) => widget != null).toList(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      leading: LeadingIconBack(),
      showCartButton: false,
      body: buildBody(),
    );
  }
}
