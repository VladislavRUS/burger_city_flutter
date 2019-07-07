import 'package:burger_city_flutter/components/button.dart';
import 'package:burger_city_flutter/components/input.dart';
import 'package:burger_city_flutter/components/text_button.dart';
import 'package:burger_city_flutter/components/text_button_checkbox.dart';
import 'package:burger_city_flutter/constants/app_colors.dart';
import 'package:burger_city_flutter/store/store.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class StartScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StartScreenState();
  }
}

class StartScreenState extends State<StartScreen> {
  static Store of(context) =>
      ScopedModel.of<Store>(context, rebuildOnChange: true);

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

  onLogin() async {
    await onStart();
  }

  Widget buildLogo() {
    return Container(
      margin: EdgeInsets.only(top: 85),
      width: 100,
      height: 120,
      child: Image.asset('assets/logo.png'),
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

  Widget buildForm() {
    Store store = of(context);

    return Container(
        margin: EdgeInsets.only(top: 60, left: 30, right: 30, bottom: 50),
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

  Widget buildBottomButtons() {
    return Container(
      padding: EdgeInsets.only(bottom: 26),
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
    return Column(
      children: <Widget>[
        buildLogo(),
        Spacer(),
        buildInfo(),
        buildStartButton()
      ],
    );
  }

  Widget buildLogin() {
    bool isKeyboardHidden = MediaQuery.of(context).viewInsets.bottom == 0;

    return SizedBox.expand(
      child: Stack(
        children: <Widget>[
          LayoutBuilder(builder: (context, constraints) {
            return ConstrainedBox(
              constraints: BoxConstraints(maxHeight: constraints.maxHeight),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[buildLogo(), buildForm()],
                ),
              ),
            );
          }),
          isKeyboardHidden
              ? Positioned.fill(
                  child: buildBottomButtons(),
                )
              : null
        ].where((widget) => widget != null).toList(),
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
