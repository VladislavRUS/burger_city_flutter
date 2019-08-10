import 'dart:async';

import 'package:burger_city_flutter/app_localizations.dart';
import 'package:burger_city_flutter/components/custom_scaffold.dart';
import 'package:burger_city_flutter/components/input.dart';
import 'package:burger_city_flutter/components/leading_arrow_back.dart';
import 'package:burger_city_flutter/models/address_description.dart';
import 'package:burger_city_flutter/store/mock.dart';
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
  List<AddressDescription> descriptions = [];
  Timer timer;

  String translate(key) {
    return AppLocalizations.of(context).translate(key);
  }

  onChanged(String text) async {
    if (timer?.isActive ?? false) timer.cancel();
    timer = Timer(const Duration(milliseconds: 500), () async {
      List<AddressDescription> foundDescriptions = await findPlace(text);
      print(foundDescriptions.length);

      setState(() {
        descriptions = foundDescriptions;
      });
    });
  }

  Future<List<AddressDescription>> findPlace(String place) async {
    Store store = of(context);

    try {
      return await store.findPlace(place);
    } catch (e) {
      return Mock.addressDescriptions;
    }
  }

  Widget buildList() {
    Store store = of(context);

    return ListView.builder(
        itemCount: descriptions.length,
        itemBuilder: (context, index) {
          var address = descriptions[index];

          return AbsorbPointer(
            absorbing: !address.isValid,
            child: ListTile(
                onTap: () {
                  store.setAddress(address);
                  Navigator.of(context).pop();
                },
                title: Opacity(
                    opacity: address.isValid ? 1 : 0.6,
                    child: Text(address.title))),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Store store = of(context);

    return CustomScaffold(
      leading: LeadingIconBack(),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Stack(
          children: <Widget>[
            Input(
              autofocus: true,
              placeholder: store.order?.addressDescription?.title ??
                  translate('address.search'),
              iconData: Icons.search,
              onChanged: onChanged,
            ),
            Container(margin: EdgeInsets.only(top: 50), child: buildList())
          ],
        ),
      ),
    );
  }
}
