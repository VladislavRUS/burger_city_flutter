import 'package:burger_city_flutter/constants/categories.dart';
import 'package:burger_city_flutter/models/product.dart';

class Burger extends Product {
  Burger(int id, int price, String name, String imageUrl)
      : super(id, price, name, Categories.BURGER, imageUrl);
}
