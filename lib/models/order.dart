import 'package:burger_city_flutter/models/burger_order.dart';

class Order {
  List<BurgerOrder> burgerOrders;
  DateTime dateTime;
  String address;

  Order() {
    burgerOrders = [];
  }
}
