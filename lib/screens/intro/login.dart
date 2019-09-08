import 'package:burger_city_flutter/components/button.dart';
import 'package:burger_city_flutter/components/input.dart';
import 'package:burger_city_flutter/components/text_button.dart';
import 'package:burger_city_flutter/components/text_button_checkbox.dart';
import 'package:burger_city_flutter/constants/app_colors.dart';
import 'package:burger_city_flutter/constants/durations.dart';
import 'package:burger_city_flutter/constants/routes.dart';
import 'package:burger_city_flutter/store/store.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../app_localizations.dart';

class LoginScreen extends StatefulWidget {
  PageController pageController;

  LoginScreen({this.pageController});

  @override
  State<StatefulWidget> createState() {
    return LoginScreenState(pageController: pageController);
  }
}

class LoginScreenState extends State<LoginScreen> {
  PageController pageController;
  bool isLoading = false;

  static Store of(BuildContext context) =>
      ScopedModel.of<Store>(context, rebuildOnChange: true);

  LoginScreenState({this.pageController});

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

  Widget buildForm() {
    Store store = of(context);

    return Container(
        margin: EdgeInsets.only(top: 60, left: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildWelcome(),
            ...buildInputs(),
            Container(
              margin: EdgeInsets.only(bottom: 35),
              child: Row(
                children: <Widget>[
                  TextButtonCheckbox(
                    text: translate('login.rememberMe'),
                    isActive: store.shouldRemember,
                    onTap: store.toggleRemember,
                  ),
                  Spacer(),
                  TextButton(translate('login.forgot'), onTap: () {})
                ],
              ),
            ),
            Button(
              isLoading: isLoading,
              text: translate('login.logIn'),
              onTap: onLogin,
            )
          ],
        ));
  }

  Widget buildWelcome() {
    return Container(
      margin: EdgeInsets.only(bottom: 25),
      child: Column(
        children: <Widget>[
          Text(translate('login.welcomeBack'),
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.w700)),
          Text(
            translate('login.loginToContinue'),
            style: TextStyle(
                fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget buildBottomButtons() {
    return Container(
      margin: EdgeInsets.only(top: 50),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 26),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextButton(
                  translate('login.newUser'),
                  onTap: () {},
                  textColor: AppColors.MAIN_COLOR,
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 20),
                width: 250,
                child: Text(
                  translate('login.termsOfService'),
                  style: TextStyle(fontSize: 10, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  List<Widget> buildInputs() {
    return [
      Container(
        margin: EdgeInsets.only(bottom: 18),
        child: Input(
          placeholder: translate('login.email'),
          iconData: Icons.alternate_email,
        ),
      ),
      Container(
        margin: EdgeInsets.only(bottom: 18),
        child: Input(
          placeholder: translate('login.password'),
          isObscured: true,
          iconData: Icons.lock_outline,
        ),
      )
    ];
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

  onLogin() async {
    showLoader();

    await Future.delayed(Durations.LOADING_DURATION);

    hideLoader();

    Navigator.pushReplacementNamed(context, Routes.APP);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          buildLogo(),
          buildForm(),
          buildBottomButtons()
        ],
      ),
    );
  }
}
