import 'package:burger_city_flutter/models/address_description.dart';
import 'package:burger_city_flutter/models/burger_order.dart';

class Order {
  List<BurgerOrder> burgerOrders;
  DateTime dateTime;
  AddressDescription address;

  Order() {
    burgerOrders = [];
  }
}
