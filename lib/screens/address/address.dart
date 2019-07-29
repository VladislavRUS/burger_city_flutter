import 'dart:async';

import 'package:burger_city_flutter/components/custom_scaffold.dart';
import 'package:burger_city_flutter/components/input.dart';
import 'package:burger_city_flutter/components/leading_arrow_back.dart';
import 'package:burger_city_flutter/store/store.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class AddressScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddressScreenState();
  }
}

class AddressScreenState extends State<AddressScreen> {
  static Store of(context) => ScopedModel.of<Store>(context);
  List<String> descriptions = [];
  Timer timer;

  onChanged(String text) async {
    if (timer?.isActive ?? false) timer.cancel();
    timer = Timer(const Duration(milliseconds: 500), () async {
      Store store = of(context);
      List<String> foundDescriptions = await store.findPlace(text);
      setState(() {
        descriptions = foundDescriptions;
      });
    });
  }

  Widget buildList() {
    return ListView.builder(
        itemCount: descriptions.length,
        itemBuilder: (context, index) {
          return ListTile(title: Text(descriptions[index]));
        });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      leading: LeadingIconBack(),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Stack(
          children: <Widget>[
            Input(
              onChanged: onChanged,
            ),
            Container(margin: EdgeInsets.only(top: 50), child: buildList())
          ],
        ),
      ),
    );
  }
}
