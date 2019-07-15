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

  Widget buildLogo() {
    return Container(
      margin: EdgeInsets.only(top: 85),
      width: 100,
      height: 120,
      child: Image.asset('assets/logo.png'),
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
                    text: 'Remember me',
                    isActive: store.shouldRemember,
                    onTap: store.toggleRemember,
                  ),
                  Spacer(),
                  TextButton(text: 'Forgot password?', onTap: () {})
                ],
              ),
            ),
            Button(
              isLoading: isLoading,
              text: 'Log in',
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

  Widget buildBottomButtons() {
    return Container(
      height: 100,
      child: Column(
        children: <Widget>[
          Spacer(),
          Container(
            margin: EdgeInsets.only(bottom: 26),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextButton(
                  onTap: () {},
                  textColor: AppColors.MAIN_COLOR,
                  text: 'New user? Sign up',
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 250,
                child: Text(
                  'By signing up you indicate that you have read and agreed to the Patch Terms of Service',
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
          placeholder: 'Email',
          iconData: Icons.alternate_email,
        ),
      ),
      Container(
        margin: EdgeInsets.only(bottom: 18),
        child: Input(
          placeholder: 'Password',
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

    Navigator.of(context).pushReplacementNamed(Routes.APP);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        children: <Widget>[
          LayoutBuilder(builder: (context, constraints) {
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  buildLogo(),
                  buildForm(),
                  buildBottomButtons()
                ],
              ),
            );
          }),
        ].where((widget) => widget != null).toList(),
      ),
    );
  }
}
