import 'package:burger_city_flutter/models/burger.dart';
import 'package:burger_city_flutter/models/condiment.dart';

class BurgerOrder {
  Burger burger;
  int quantity;
  List<Condiment> condiments;

  BurgerOrder(this.burger) {
    quantity = 1;
    condiments = [];
  }
}