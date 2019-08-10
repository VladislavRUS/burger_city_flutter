import 'package:burger_city_flutter/app_localizations.dart';
import 'package:burger_city_flutter/components/button.dart';
import 'package:burger_city_flutter/components/custom_scaffold.dart';
import 'package:burger_city_flutter/components/info_panel.dart';
import 'package:burger_city_flutter/components/info_panel_text.dart';
import 'package:burger_city_flutter/components/leading_arrow_back.dart';
import 'package:burger_city_flutter/components/title_text.dart';
import 'package:burger_city_flutter/constants/app_colors.dart';
import 'package:burger_city_flutter/store/store.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';

class DateAndTimeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DateAndTimeScreenScreen();
  }
}

class DateAndTimeScreenScreen extends State<DateAndTimeScreen> {
  static Store of(context) =>
      ScopedModel.of<Store>(context, rebuildOnChange: true);
  DateTime dateTime;
  TimeOfDay timeOfDay;

  String translate(key) {
    return AppLocalizations.of(context).translate(key);
  }

  onSelect() {
    Store store = of(context);
    DateTime orderDateTime = DateTime(dateTime.year, dateTime.month,
        dateTime.day, timeOfDay.hour, timeOfDay.minute);
    store.setOrderDateTime(orderDateTime);
    Navigator.of(context).pop();
  }

  openDatePicker() async {
    DateTime picked = await showDatePicker(
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData(
              primaryColor: AppColors.MAIN_DARK_COLOR,
              accentColor: AppColors.MAIN_COLOR,
            ),
            child: child,
          );
        },
        context: context,
        firstDate: DateTime.now().subtract(Duration(days: 1)),
        initialDate: dateTime,
        lastDate: DateTime.now().add(Duration(days: 2)));

    if (picked != null) {
      setState(() {
        dateTime = picked;
      });
    }
  }

  openTimePicker() async {
    TimeOfDay pickedTimeOfDay = await showTimePicker(
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData(
              primaryColor: AppColors.MAIN_DARK_COLOR,
              accentColor: AppColors.MAIN_COLOR,
            ),
            child: child,
          );
        },
        context: context,
        initialTime: timeOfDay);

    if (pickedTimeOfDay != null) {
      setState(() {
        timeOfDay = pickedTimeOfDay;
      });
    }
  }

  Widget buildDate() {
    var format = DateFormat(translate('dateAndTime.dateFormat'));
    String formattedDate = format.format(dateTime);

    return Container(
      margin: EdgeInsets.only(bottom: 37),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TitleText(translate('dateAndTime.pickupDate')),
          Container(
              margin: EdgeInsets.only(bottom: 16),
              child: Text(
                translate('dateAndTime.selectDate'),
                style: TextStyle(
                    fontSize: 15,
                    color: AppColors.MAIN_DARK_COLOR,
                    fontWeight: FontWeight.w600),
              )),
          Theme(
            data: ThemeData.dark(),
            child: InfoPanel(
              onTap: openDatePicker,
              child: Row(
                children: <Widget>[
                  InfoPanelText(formattedDate),
                  Spacer(),
                  Icon(
                    Icons.calendar_today,
                    color: AppColors.DARK_ICON_COLOR,
                    size: 18,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildTime() {
    var format = DateFormat(translate('dateAndTime.timeFormat'));
    DateTime now = DateTime.now();
    DateTime dateTime = DateTime(
        now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
    String formattedTime = format.format(dateTime);

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TitleText(translate('dateAndTime.pickupTime')),
          Container(
              margin: EdgeInsets.only(bottom: 16),
              child: Text(
                translate('dateAndTime.selectTime'),
                style: TextStyle(
                    fontSize: 15,
                    color: AppColors.MAIN_DARK_COLOR,
                    fontWeight: FontWeight.w600),
              )),
          Theme(
            data: ThemeData.dark(),
            child: InfoPanel(
              onTap: openTimePicker,
              child: Row(
                children: <Widget>[
                  InfoPanelText(formattedTime),
                  Spacer(),
                  Icon(
                    Icons.access_time,
                    color: AppColors.DARK_ICON_COLOR,
                    size: 18,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    Store store = of(context);

    if (dateTime == null && timeOfDay == null && store.order.dateTime != null) {
      dateTime = store.order.dateTime;
      timeOfDay = TimeOfDay.fromDateTime(dateTime);
    } else {
      var now = DateTime.now().add(Duration(hours: 1));
      dateTime = now;
      timeOfDay = TimeOfDay.fromDateTime(now);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      leading: LeadingIconBack(),
      showCartButton: false,
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[buildDate(), buildTime()],
                ),
              ),
            ),
          ),
          Positioned(
            left: 20,
            bottom: 20,
            right: 20,
            child: Button(
                text: translate('dateAndTime.select'),
                isLoading: false,
                onTap: onSelect),
          )
        ],
      ),
    );
  }
}
