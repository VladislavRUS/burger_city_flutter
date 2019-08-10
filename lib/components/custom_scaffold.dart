import 'package:burger_city_flutter/app_localizations.dart';
import 'package:burger_city_flutter/constants/app_colors.dart';
import 'package:burger_city_flutter/models/available_locale.dart';
import 'package:burger_city_flutter/store/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scoped_model/scoped_model.dart';

import 'cart_button.dart';

class CustomScaffold extends StatelessWidget {
  final Widget body;
  final Widget leading;
  final Widget bottomNavigationBar;
  final bool showCartButton;

  CustomScaffold(
      {this.body,
      this.leading,
      this.bottomNavigationBar,
      this.showCartButton = true});

  onShowLanguageSelect(BuildContext context) async {
    Store store = ScopedModel.of(context);

    List<PopupMenuEntry> items = store.availableLocales
        .map((availableLocale) => PopupMenuItem(
            value: availableLocale,
            child: Container(
              child: Row(
                children: <Widget>[
                  Text(
                    availableLocale.name,
                    style: TextStyle(
                        fontWeight:
                            AppLocalizations.of(context).locale.languageCode ==
                                    availableLocale.languageCode
                                ? FontWeight.w600
                                : FontWeight.w400),
                  ),
                  Spacer(),
                  Image.asset(availableLocale.icon),
                ],
              ),
            )))
        .toList();

    AvailableLocale locale = await showMenu(
        context: context,
        position: RelativeRect.fromLTRB(0, 60, 0, 0),
        items: items);

    if (locale != null) {
      store.setLocale(Locale(locale.languageCode, locale.countryCode));
    }
  }

  @override
  Widget build(BuildContext context) {
    Locale locale = AppLocalizations.of(context).locale;

    return Scaffold(
      bottomNavigationBar: bottomNavigationBar,
      appBar: AppBar(
        leading: leading ??
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  onShowLanguageSelect(context);
                },
                child: Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Text(locale.languageCode.toUpperCase(),
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
          child: SvgPicture.asset('assets/images/logo-title.svg'),
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
