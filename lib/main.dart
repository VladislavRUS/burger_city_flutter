import 'package:burger_city_flutter/screens/start.dart';
import 'package:burger_city_flutter/store/store.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'constants/routes.dart';

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
      initialRoute: Routes.START,
      routes: {Routes.START: (_) => StartScreen()},
    );
  }
}
