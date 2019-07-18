import 'package:burger_city_flutter/models/condiment.dart';

class CondimentOrder {
  Condiment condiment;
  int quantity;

  CondimentOrder(this.condiment) {
    quantity = 1;
  }
}