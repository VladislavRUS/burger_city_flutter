import 'dart:convert';

import 'package:burger_city_flutter/app_localizations.dart';
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
import 'package:flutter_localizations/flutter_localizations.dart';
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
    Store store = ScopedModel.of(context, rebuildOnChange: true);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.INTRO,
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
      locale: store.locale,
      supportedLocales: [Locale('en', 'US'), Locale('ru', 'RU')],
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode &&
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }

        return supportedLocales.first;
      },
    );
  }
}
