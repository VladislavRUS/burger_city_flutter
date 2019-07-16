import 'package:burger_city_flutter/constants/routes.dart';
import 'package:burger_city_flutter/screens/app/app.dart';
import 'package:burger_city_flutter/screens/customize/customize.dart';
import 'package:burger_city_flutter/screens/intro/intro.dart';
import 'package:burger_city_flutter/store/store.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  Store store = Store();
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
      },
    );
  }
}
