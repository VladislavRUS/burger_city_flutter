import 'package:burger_city_flutter/constants/app_colors.dart';
import 'package:burger_city_flutter/models/burger_order.dart';
import 'package:burger_city_flutter/models/order.dart';
import 'package:flutter/material.dart';

class OrderItems extends StatelessWidget {
  final Order order;

  OrderItems({this.order});

  Widget buildOrder(BurgerOrder burgerOrder) {
    return Container(
      margin: EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Color.fromARGB(20, 0, 0, 0),
                spreadRadius: 8,
                blurRadius: 15)
          ],
          borderRadius: BorderRadius.circular(6)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 10),
                width: 125,
                height: 125,
                child: Image.asset(burgerOrder.burger.imageUrl),
              ),
              Container(
                margin: EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 4),
                      child: Text(
                        '${burgerOrder.quantity} ${burgerOrder.burger.name}',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.MAIN_DARK_COLOR),
                      ),
                    ),
                    Text(
                      '${burgerOrder.burger.name}',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.DARK_ICON_COLOR),
                    ),
                  ],
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(bottom: 15, right: 15),
                child: Text(
                  '${burgerOrder.burger.price.toString()} \$',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: AppColors.MAIN_COLOR),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> orders = [];

    order.burgerOrders.forEach((burgerOrder) {
      orders.add(buildOrder(burgerOrder));
    });

    return Container(
      child: Column(
        children: orders,
      ),
    );
  }
}
