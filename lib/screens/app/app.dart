import 'package:burger_city_flutter/screens/home/home.dart';
import 'package:flutter/material.dart';

class AppScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AppScreenState();
  }
}

class AppScreenState extends State<AppScreen> {
  PageView pageView;

  @override
  void initState() {
    super.initState();

    PageController controller = PageController();

    pageView = PageView(
      controller: controller,
      children: <Widget>[HomeScreen()],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Container(
            margin: EdgeInsets.only(left: 20),
            width: 45,
            height: 27,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/lang-title.png'))),
          ),
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
        ),
        body: pageView);
  }
}
