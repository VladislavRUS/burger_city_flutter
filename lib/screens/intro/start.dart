import 'package:burger_city_flutter/app_localizations.dart';
import 'package:burger_city_flutter/components/big_text.dart';
import 'package:burger_city_flutter/components/button.dart';
import 'package:burger_city_flutter/constants/durations.dart';
import 'package:flutter/material.dart';

class StartScreen extends StatefulWidget {
  final PageController pageController;

  StartScreen({this.pageController});

  @override
  State<StatefulWidget> createState() {
    return StartScreenState(pageController: pageController);
  }
}

class StartScreenState extends State<StartScreen> {
  PageController pageController;
  bool isLoading = false;

  StartScreenState({this.pageController});

  String translate(key) {
    return AppLocalizations.of(context).translate(key);
  }

  Widget buildLogo() {
    return Container(
      margin: EdgeInsets.only(top: 85),
      width: 100,
      height: 120,
      child: Image.asset('assets/images/logo.png'),
    );
  }

  Widget buildInfo() {
    return Row(
      children: <Widget>[
        Container(
            margin: EdgeInsets.only(bottom: 35, left: 30),
            width: 130,
            child: BigText(translate('start.title'))),
      ],
    );
  }

  Widget buildStartButton() {
    return Container(
      margin: EdgeInsets.only(bottom: 80, left: 30, right: 30),
      child: Button(
        text: translate('start.getStarted'),
        isLoading: isLoading,
        onTap: onStart,
      ),
    );
  }

  onStart() async {
    showLoader();

    await Future.delayed(Durations.LOADING_DURATION);

    hideLoader();

    pageController.animateToPage(1,
        duration: Durations.PAGE_TRANSITION_DURATION, curve: Curves.easeInOut);
  }

  showLoader() {
    setState(() {
      isLoading = true;
    });
  }

  hideLoader() {
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        buildLogo(),
        Spacer(),
        buildInfo(),
        buildStartButton()
      ],
    );
  }
}
