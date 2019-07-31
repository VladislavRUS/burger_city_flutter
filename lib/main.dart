import 'dart:convert';

import 'package:burger_city_flutter/constants/routes.dart';
import 'package:burger_city_flutter/screens/address/address.dart';
import 'package:burger_city_flutter/screens/app/app.dart';
import 'package:burger_city_flutter/screens/cart/cart.dart';
import 'package:burger_city_flutter/screens/customize/customize.dart';
import 'package:burger_city_flutter/screens/date_and_time/date_and_time.dart';
import 'package:burger_city_flutter/screens/delivery_details/delivery_details.dart';
import 'package:burger_city_flutter/screens/intro/intro.dart';
import 'package:burger_city_flutter/screens/order/order.dart';
import 'package:burger_city_flutter/store/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';

import 'models/config.dart';

main() async {
  String config = await rootBundle.loadString('assets/config.json');
  Store store = Store(config: Config.fromJson(jsonDecode(config)));

  runApp(ScopedModel(
    child: MyApp(),
    model: store,
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Routes.APP,
      routes: {
        Routes.INTRO: (_) => IntroScreen(),
        Routes.APP: (_) => AppScreen(),
        Routes.CUSTOMIZE: (_) => CustomizeScreen(),
        Routes.CART: (_) => CartScreen(),
        Routes.DELIVERY_DETAILS: (_) => DeliveryDetailsScreen(),
        Routes.DATE_AND_TIME: (_) => DateAndTimeScreen(),
        Routes.ADDRESS: (_) => AddressScreen(),
        Routes.ORDER: (_) => OrderScreen(),
      },
    );
  }
}
