import 'package:burger_city_flutter/app_localizations.dart';
import 'package:burger_city_flutter/components/button.dart';
import 'package:burger_city_flutter/components/custom_scaffold.dart';
import 'package:burger_city_flutter/components/leading_arrow_back.dart';
import 'package:burger_city_flutter/components/loader.dart';
import 'package:burger_city_flutter/components/quantity_button.dart';
import 'package:burger_city_flutter/constants/app_colors.dart';
import 'package:burger_city_flutter/models/product.dart';
import 'package:burger_city_flutter/models/product_order.dart';
import 'package:burger_city_flutter/store/store.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class CustomizeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CustomizeScreenState();
  }
}

class CustomizeScreenState extends State<CustomizeScreen> {
  static Store of(context) => ScopedModel.of<Store>(context);
  int quantity = 1;
  bool isAddingToCard = false;
  bool isInitialized = false;
  Product product;

  String translate(key) {
    return AppLocalizations.of(context).translate(key);
  }

  inc() {
    setState(() {
      quantity = quantity + 1;
    });
  }

  dec() {
    if (quantity == 1) {
      return;
    }

    setState(() {
      quantity = quantity - 1;
    });
  }

  @override
  void didChangeDependencies() {
    if (!isInitialized) {
      Store store = of(context);

      if (store.currentCombo != null) {
        product = store.currentCombo;
      } else {
        product = store.currentBurger;
      }

      setState(() {
        isInitialized = true;
      });
    }
  }

  onAddToCart() async {
    showLoader();

    Store store = of(context);

    ProductOrder productOrder = ProductOrder(product, quantity);

    await store.addToCart(productOrder);

    hideLoader();
    Navigator.of(context).pop();
  }

  showLoader() {
    setState(() {
      isAddingToCard = true;
    });
  }

  hideLoader() {
    setState(() {
      isAddingToCard = false;
    });
  }

  Widget buildHeader() {
    Store store = of(context);

    return Container(
      margin: EdgeInsets.only(top: 28, left: 20, right: 20, bottom: 36),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 4),
            child: Text(product.name,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.MAIN_DARK_COLOR)),
          ),
          Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Text(
                translate('customize.pleaseCustomize'),
                style: TextStyle(
                    fontSize: 15,
                    color: AppColors.MAIN_DARK_COLOR,
                    fontWeight: FontWeight.w600),
              )),
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  height: 150,
                  child: Hero(
                    tag: product.id.toString(),
                    child: Image.asset(product.imageUrl),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget buildButtons() {
    return Container(
      padding: EdgeInsets.only(bottom: 20),
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Row(
        children: <Widget>[
          Expanded(
              child: Container(
                  child: QuantityButton(quantity.toString(), dec, inc))),
          Container(
              margin: EdgeInsets.only(left: 8),
              width: 190,
              child: Button(
                text: translate('customize.addToCart'),
                onTap: onAddToCart,
                isLoading: isAddingToCard,
              ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        showCartButton: false,
        leading: LeadingIconBack(),
        body: isInitialized
            ? SingleChildScrollView(
                child: Column(
                  children: <Widget>[buildHeader(), buildButtons()],
                ),
              )
            : Center(child: Loader()));
  }
}
