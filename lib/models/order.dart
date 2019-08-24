import 'package:burger_city_flutter/models/address_description.dart';
import 'package:burger_city_flutter/models/product_order.dart';

class Order {
  List<ProductOrder> productOrders = [];
  DateTime dateTime;
  bool isInAdvance = false;
  bool isConfirmed = false;
  AddressDescription addressDescription;

  addProductOrder(ProductOrder newProductOrder) {
    var existingProductOrder = productOrders.firstWhere((productOrder) {
      return newProductOrder.product.category ==
              productOrder.product.category &&
          newProductOrder.product.id == productOrder.product.id;
    }, orElse: () => null);

    if (existingProductOrder != null) {
      existingProductOrder.quantity += newProductOrder.quantity;
    } else {
      productOrders.add(newProductOrder);
    }
  }

  Order() {}

  Order.fromOrder(Order order) {
    productOrders = order.productOrders.sublist(0);
    if (order.dateTime != null) {
      dateTime = DateTime.fromMicrosecondsSinceEpoch(
          order.dateTime.millisecondsSinceEpoch);
    }
    isInAdvance = order.isInAdvance;
    isConfirmed = order.isConfirmed;
    AddressDescription description = order.addressDescription;
    addressDescription = AddressDescription(
        description.id, description.title, description.isValid);
  }
}
