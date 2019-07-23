import 'package:burger_city_flutter/models/burger_order.dart';

class Order {
  List<BurgerOrder> burgerOrders;
  DateTime dateTime;

  Order() {
    burgerOrders = [];
    dateTime = DateTime.now().add(Duration(hours: 1));
  }
}
