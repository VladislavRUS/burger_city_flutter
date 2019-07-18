import 'dart:async';

import 'package:burger_city_flutter/components/big_text.dart';
import 'package:burger_city_flutter/components/sticker.dart';
import 'package:burger_city_flutter/components/title_text.dart';
import 'package:burger_city_flutter/constants/durations.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  List<String> headerTexts = [
    '''World`s Greatest \nBurgers.''',
    '''Tasty And Incredibly\nDelicious.''',
    '''You Should Definitely \nTry It.''',
  ];

  PageController headerPageController = PageController();
  int currentHeaderPage = 0;
  Timer headerTimer;
  List<String> offers = [
    'assets/offers/offer1.png',
    'assets/offers/offer2.png',
    'assets/offers/offer3.png',
    'assets/offers/offer1.png',
    'assets/offers/offer2.png',
    'assets/offers/offer3.png',
  ];

  Widget buildHeader() {
    return Container(
      height: 241,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/home-header-bg.png'))),
      child: PageView.builder(
          physics: NeverScrollableScrollPhysics(),
          controller: headerPageController,
          itemBuilder: (context, index) {
            return Container(
                margin: EdgeInsets.only(top: 20, left: 20),
                child: BigText(headerTexts[index]));
          },
          itemCount: headerTexts.length),
    );
  }

  Widget buildOffers() {
    return Container(
      margin: EdgeInsets.only(bottom: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              margin: EdgeInsets.all(22), child: TitleText('Best Offers')),
          buildOffersList()
        ],
      ),
    );
  }

  Widget buildOffersList() {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 180),
      child: Container(
        child: ListView.builder(
            itemBuilder: (context, index) {
              double rightMargin = index == offers.length - 1 ? 22 : 22;
              double leftMargin = index == 0 ? 22 : 0;

              return Container(
                margin: EdgeInsets.only(left: leftMargin, right: rightMargin),
                width: 130,
                height: 180,
                decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage(offers[index]))),
              );
            },
            scrollDirection: Axis.horizontal,
            itemCount: offers.length),
      ),
    );
  }

  Widget buildStickers() {
    return Container(
      margin: EdgeInsets.all(22),
      child: Column(
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(bottom: 15),
              child: Sticker('Track Here', 'Login to continue Burger City')),
          Sticker('Order Here', 'Login to continue Burger City'),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    headerTimer = Timer.periodic(Duration(seconds: 5), (timer) {
      if (currentHeaderPage < headerTexts.length - 1) {
        currentHeaderPage++;
      } else {
        currentHeaderPage = 0;
      }

      headerPageController.animateToPage(currentHeaderPage,
          duration: Durations.PAGE_TRANSITION_DURATION,
          curve: Curves.easeInOut);
    });
  }

  @override
  void dispose() {
    super.dispose();
    headerTimer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: <Widget>[buildHeader(), buildStickers(), buildOffers()],
    ));
  }
}
