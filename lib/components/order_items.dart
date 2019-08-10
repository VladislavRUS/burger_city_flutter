import 'package:burger_city_flutter/constants/app_colors.dart';
import 'package:burger_city_flutter/models/order.dart';
import 'package:burger_city_flutter/models/product_order.dart';
import 'package:flutter/material.dart';

class OrderItems extends StatelessWidget {
  final Order order;
  final Function translate;

  OrderItems(this.order, this.translate);

  Widget buildOrder(ProductOrder productOrder) {
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
      child: IntrinsicHeight(
        child: Row(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  margin: EdgeInsets.only(left: 20),
                  width: 125,
                  height: 125,
                  child: Image.asset(productOrder.product.imageUrl),
                ),
              ],
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(bottom: 4),
                          child: Text(
                            '${productOrder.quantity} ${translate(productOrder.product.keyName)}',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: AppColors.MAIN_DARK_COLOR),
                          ),
                        ),
                        Text(
                          '${translate(productOrder.product.keyName)}',
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
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(bottom: 15, right: 15),
                  child: Text(
                    '${productOrder.product.price.toString()} \$',
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> orders = [];

    order.productOrders.forEach((productOrder) {
      orders.add(buildOrder(productOrder));
    });

    return Container(
      child: Column(
        children: orders,
      ),
    );
  }
}
