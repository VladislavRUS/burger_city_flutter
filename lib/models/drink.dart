import 'package:burger_city_flutter/constants/categories.dart';
import 'package:burger_city_flutter/models/product.dart';

class Drink extends Product {
  Drink(int id, int price, String keyName, String imageUrl)
      : super(id, price, keyName, Categories.DRINK, imageUrl);
}
