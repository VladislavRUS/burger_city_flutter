import 'package:burger_city_flutter/components/button.dart';
import 'package:flutter/material.dart';

class StartScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StartScreenState();
  }
}

class StartScreenState extends State<StartScreen> {
  bool isLoading = false;

  onStart() async {
    setState(() {
      isLoading = true;
    });

    await Future.delayed(Duration(seconds: 1));

    setState(() {
      isLoading = false;
    });
  }

  Widget buildLogo() {
    return Positioned(
      left: 0,
      right: 0,
      top: 85,
      child: Container(
        width: 100,
        height: 120,
        child: Image.asset('assets/logo.png'),
      ),
    );
  }

  Widget buildButton() {
    return Positioned(
      bottom: 80,
      left: 30,
      right: 30,
      child: Button(
        text: 'Get start here',
        isLoading: isLoading,
        onTap: onStart,
      ),
    );
  }

  Widget buildInfo() {
    return Positioned(
      left: 30,
      bottom: 180,
      child: Container(
          width: 120,
          child: Text(
            'Worlds Greatest Burgers.',
            style: TextStyle(
                height: 1.05,
                fontSize: 31,
                color: Colors.white,
                fontWeight: FontWeight.w700),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/bg-darken.png'),
                  fit: BoxFit.cover)),
          child: Stack(
            children: <Widget>[buildLogo(), buildInfo(), buildButton()],
          )),
    );
  }
}
