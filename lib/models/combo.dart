import 'package:burger_city_flutter/constants/categories.dart';
import 'package:burger_city_flutter/models/product.dart';

class Combo extends Product {
  List<Product> products;

  Combo(int id, int price, String keyName, String imageUrl, this.products)
      : super(id, price, keyName, Categories.COMBO, imageUrl);
}
