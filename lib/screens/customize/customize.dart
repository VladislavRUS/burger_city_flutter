import 'package:burger_city_flutter/components/button.dart';
import 'package:burger_city_flutter/components/quantity_button.dart';
import 'package:burger_city_flutter/constants/app_colors.dart';
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

  onAddToCart() async {
    showLoader();
    await Future.delayed(Duration(seconds: 2));
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
            child: Text(store.currentOrder.burger.name,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.MAIN_DARK_COLOR)),
          ),
          Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Text(
                'Please customize your meal',
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
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(store.currentOrder.burger.imageUrl),
                          fit: BoxFit.contain)),
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
                text: 'Add to card',
                onTap: onAddToCart,
                isLoading: isAddingToCard,
              ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: AppColors.MAIN_COLOR,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Container(
          width: 66,
          height: 22,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/logo-title.png'))),
        ),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 20),
            width: 19,
            height: 18,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/icons/cart.png'))),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[buildHeader(), buildButtons()],
        ),
      ),
    );
  }
}
