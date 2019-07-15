import 'package:flutter/material.dart';

import 'package:burger_city_flutter/screens/intro/login.dart';

import 'package:burger_city_flutter/screens/intro/start.dart';

class IntroScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return IntroScreenState();
  }
}

class IntroScreenState extends State<IntroScreen> {
  PageView pageView;

  @override
  void initState() {
    super.initState();

    PageController controller = PageController();

    pageView = PageView(
        controller: controller,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          StartScreen(pageController: controller),
          LoginScreen(pageController: controller)
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/bg-darken.png'), fit: BoxFit.cover)),
        child: Scaffold(backgroundColor: Colors.transparent, body: pageView));
  }
}
