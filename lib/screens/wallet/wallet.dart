import 'package:burger_city_flutter/components/info_panel.dart';
import 'package:burger_city_flutter/components/info_panel_text.dart';
import 'package:burger_city_flutter/components/round_checkmark.dart';
import 'package:burger_city_flutter/components/title_text.dart';
import 'package:burger_city_flutter/models/order_payment.dart';
import 'package:burger_city_flutter/store/store.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class WalletScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return WalletScreenState();
  }
}

class WalletScreenState extends State<WalletScreen> {
  static Store of(context) =>
      ScopedModel.of<Store>(context, rebuildOnChange: true);

  List<OrderPayment> orderPayments = [
    OrderPayment(name: 'M Wallet'),
    OrderPayment(name: 'Cash on Delivery'),
    OrderPayment(name: 'Apple Pay'),
    OrderPayment(name: 'Samsung Pay '),
  ];

  Widget buildTitle() {
    return Container(
        margin: EdgeInsets.only(bottom: 20), child: TitleText('Order payment'));
  }

  Widget buildOptions() {
    Store store = of(context);

    List<Widget> options = [];

    orderPayments.forEach((orderPayment) {
      options.add(Container(
        margin: EdgeInsets.only(bottom: 24),
        child: InfoPanel(
            onTap: () {
              onOrderPayment(orderPayment);
            },
            child: Row(
              children: <Widget>[
                InfoPanelText(orderPayment.name),
                Spacer(),
                RoundCheckmark(
                  isSelected: store.orderPayment?.name == orderPayment.name,
                )
              ],
            )),
      ));
    });

    return Column(
      children: options,
    );
  }

  onOrderPayment(OrderPayment orderPayment) {
    Store store = of(context);
    store.setOrderPayment(orderPayment);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned.fill(
              child: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[buildTitle(), buildOptions()],
            ),
          ))
        ],
      ),
    );
  }
}
