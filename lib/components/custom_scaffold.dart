import 'package:burger_city_flutter/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'cart_button.dart';

class CustomScaffold extends StatelessWidget {
  Widget body;
  Widget leading;
  Widget bottomNavigationBar;
  bool showCartButton;

  CustomScaffold(
      {this.body,
      this.leading,
      this.bottomNavigationBar,
      this.showCartButton = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomNavigationBar,
      appBar: AppBar(
        leading: leading ??
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.only(left: 13),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Text('EN',
                            style: TextStyle(
                                color: AppColors.MAIN_COLOR,
                                fontSize: 18,
                                fontWeight: FontWeight.w700)),
                      ),
                      Container(
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          size: 20,
                          color: AppColors.MAIN_COLOR,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Container(
          width: 66,
          height: 22,
          child: SvgPicture.asset('assets/logo-title.svg'),
        ),
        actions: <Widget>[
          showCartButton
              ? Container(
                  margin: EdgeInsets.only(right: 20),
                  width: 19,
                  height: 18,
                  child: CartButton(),
                )
              : null
        ].where((widget) => widget != null).toList(),
      ),
      body: body,
    );
  }
}
