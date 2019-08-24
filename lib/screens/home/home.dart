import 'dart:async';

import 'package:burger_city_flutter/app_localizations.dart';
import 'package:burger_city_flutter/components/big_text.dart';
import 'package:burger_city_flutter/components/ripple_image.dart';
import 'package:burger_city_flutter/components/sticker.dart';
import 'package:burger_city_flutter/components/title_text.dart';
import 'package:burger_city_flutter/constants/app_pages.dart';
import 'package:burger_city_flutter/constants/durations.dart';
import 'package:burger_city_flutter/constants/routes.dart';
import 'package:burger_city_flutter/models/combo.dart';
import 'package:burger_city_flutter/store/store.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class HomeScreen extends StatefulWidget {
  Function onChangePage;

  HomeScreen({this.onChangePage});

  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  static Store of(context) =>
      ScopedModel.of<Store>(context, rebuildOnChange: true);
  bool isInitialized = false;

  PageController headerPageController = PageController();
  List<String> headerTexts = [
    'home.greatest',
    'home.tasty',
    'home.tryIt',
  ];
  int currentHeaderPage = 0;
  Timer headerTimer;

  String translate(key) {
    return AppLocalizations.of(context).translate(key);
  }

  Widget buildHeader() {
    return Container(
      height: 241,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/home-bg.jpg'))),
      child: PageView.builder(
          physics: NeverScrollableScrollPhysics(),
          controller: headerPageController,
          itemBuilder: (context, index) {
            return Container(
                margin: EdgeInsets.only(top: 20, left: 20),
                child: BigText(translate(headerTexts[index])));
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
              margin: EdgeInsets.all(22),
              child: TitleText(translate('home.bestOffers'))),
          buildOffersList()
        ],
      ),
    );
  }

  Widget buildOffersList() {
    Store store = of(context);
    List<Combo> combos = store.combos;

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 180),
      child: Container(
        child: ListView.builder(
            itemBuilder: (context, index) {
              Combo combo = combos[index];

              double rightMargin = index == combos.length - 1 ? 22 : 22;
              double leftMargin = index == 0 ? 22 : 0;

              return Container(
                margin: EdgeInsets.only(left: leftMargin, right: rightMargin),
                child: Container(
                  child: RippleImage(
                    130,
                    180,
                    combo.imageUrl,
                    borderRadius: 6,
                    onTap: () {
                      store.setCurrentCombo(combo);
                      Navigator.of(context).pushNamed(Routes.CUSTOMIZE);
                    },
                  ),
                ),
              );
            },
            scrollDirection: Axis.horizontal,
            itemCount: combos.length),
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
              child: Sticker(
                translate('home.trackHere'),
                translate('home.trackHereSubtitle'),
                onTap: () {
                  widget.onChangePage(AppPages.TRACK_ORDERS);
                },
              )),
          Sticker(
            translate('home.orderHere'),
            translate('home.orderHereSubtitle'),
            onTap: () {
              widget.onChangePage(AppPages.BURGERS);
            },
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    headerTimer = Timer.periodic(Duration(seconds: 3), (timer) {
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
    headerTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: <Widget>[buildHeader(), buildStickers(), buildOffers()],
    ));
  }
}
