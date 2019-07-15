import 'package:burger_city_flutter/components/button.dart';
import 'package:burger_city_flutter/constants/durations.dart';
import 'package:flutter/material.dart';

class StartScreen extends StatefulWidget {
  PageController pageController;

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

  Widget buildLogo() {
    return Container(
      margin: EdgeInsets.only(top: 85),
      width: 100,
      height: 120,
      child: Image.asset('assets/logo.png'),
    );
  }

  Widget buildInfo() {
    return Row(
      children: <Widget>[
        Container(
            margin: EdgeInsets.only(bottom: 35, left: 30),
            width: 120,
            child: Text(
              'World`s Greatest Burgers.',
              style: TextStyle(
                  height: 1.05,
                  fontSize: 31,
                  color: Colors.white,
                  fontWeight: FontWeight.w700),
            )),
      ],
    );
  }

  Widget buildStartButton() {
    return Container(
      margin: EdgeInsets.only(bottom: 80, left: 30, right: 30),
      child: Button(
        text: 'Get start here',
        isLoading: isLoading,
        onTap: onStart,
      ),
    );
  }

  onStart() async {
    showLoader();

    await Future.delayed(Duration(seconds: 1));

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
