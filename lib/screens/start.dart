import 'package:burger_city_flutter/components/button.dart';
import 'package:burger_city_flutter/components/input.dart';
import 'package:flutter/material.dart';

class StartScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StartScreenState();
  }
}

class StartScreenState extends State<StartScreen> {
  bool isLoading = false;
  bool isStarted = false;

  onStart() async {
    setState(() {
      isLoading = true;
    });

    await Future.delayed(Duration(seconds: 1));

    setState(() {
      isStarted = true;
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

  Widget buildForm() {
    return Container(
        margin: EdgeInsets.only(top: 250, left: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[buildWelcome(), ...buildInputs()],
        ));
  }

  List<Widget> buildInputs() {
    return [
      Container(
        margin: EdgeInsets.only(bottom: 18),
        child: Input(
          placeholder: 'Email',
          iconData: Icons.alternate_email,
        ),
      ),
      Input(
        placeholder: 'Password',
        iconData: Icons.lock_outline,
      )
    ];
  }

  Widget buildWelcome() {
    return Container(
      margin: EdgeInsets.only(bottom: 25),
      child: Column(
        children: <Widget>[
          Text('Welcome Back!',
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.w700)),
          Text(
            'Login to continue Burger City',
            style: TextStyle(
                fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget buildStart() {
    return Stack(
      children: <Widget>[buildLogo(), buildInfo(), buildButton()],
    );
  }

  Widget buildLogin() {
    return SingleChildScrollView(
      child: Stack(
        children: <Widget>[buildLogo(), buildForm()],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/bg-darken.png'), fit: BoxFit.cover)),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: isStarted ? buildLogin() : buildStart()),
    );
  }
}
