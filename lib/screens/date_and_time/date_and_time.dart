import 'package:burger_city_flutter/components/custom_scaffold.dart';
import 'package:burger_city_flutter/components/info_panel.dart';
import 'package:burger_city_flutter/components/info_panel_text.dart';
import 'package:burger_city_flutter/components/leading_arrow_back.dart';
import 'package:burger_city_flutter/components/title_text.dart';
import 'package:burger_city_flutter/constants/app_colors.dart';
import 'package:burger_city_flutter/store/store.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class DateAndTimeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DateAndTimeScreenScreen();
  }
}

class DateAndTimeScreenScreen extends State<DateAndTimeScreen> {
  static Store of(context) => ScopedModel.of<Store>(context);
  DateTime dateTime;

  Widget buildDate() {
    Store store = of(context);


    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TitleText('Pickup Date'),
          Container(
              margin: EdgeInsets.only(bottom: 16),
              child: Text(
                'Please select Pickup Date',
                style: TextStyle(
                    fontSize: 15,
                    color: AppColors.MAIN_DARK_COLOR,
                    fontWeight: FontWeight.w600),
              )),
          InfoPanel(
            child: Row(
              children: <Widget>[
                InfoPanelText(store.order.dateTime.toString())
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      leading: LeadingIconBack(),
      showCartButton: false,
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[buildDate()],
              ),
            ),
          )
        ],
      ),
    );
  }
}
