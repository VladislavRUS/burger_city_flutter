import 'package:burger_city_flutter/constants/durations.dart';
import 'package:burger_city_flutter/models/address_description.dart';
import 'package:burger_city_flutter/models/burger.dart';
import 'package:burger_city_flutter/models/burger_order.dart';
import 'package:burger_city_flutter/models/config.dart';
import 'package:burger_city_flutter/models/order.dart';
import 'package:burger_city_flutter/models/order_payment.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:requests/requests.dart';

List<Burger> burgersList = [
  Burger(1, 'assets/burgers/burger1.png', 'Chiken Big Burger', 380),
  Burger(2, 'assets/burgers/burger2.png', 'Chiken Spicy Burger', 320),
  Burger(3, 'assets/burgers/burger3.png', 'Beef Burger', 420),
  Burger(4, 'assets/burgers/burger4.png', 'Cheesy Burger', 290),
  Burger(5, 'assets/burgers/burger1.png', 'Chiken Big Burger', 380),
  Burger(6, 'assets/burgers/burger2.png', 'Chiken Spicy Burger', 320),
  Burger(7, 'assets/burgers/burger3.png', 'Beef Burger', 420),
  Burger(8, 'assets/burgers/burger4.png', 'Cheesy Burger', 290),
  Burger(9, 'assets/burgers/burger1.png', 'Chiken Big Burger', 380),
  Burger(10, 'assets/burgers/burger2.png', 'Chiken Spicy Burger', 320),
  Burger(11, 'assets/burgers/burger3.png', 'Beef Burger', 420),
  Burger(12, 'assets/burgers/burger4.png', 'Cheesy Burger', 290),
];

class Store extends Model {
  bool shouldRemember;
  List<Burger> burgers = [];
  Burger currentBurger;
  Order order;
  Config config;
  OrderPayment orderPayment;

  Store({this.config}) {
    order = Order();
    burgers = [];
    shouldRemember = false;
  }

  toggleRemember() {
    shouldRemember = !shouldRemember;
    notifyListeners();
  }

  Future fetchBurgers() async {
    await Future.delayed(Durations.REQUEST_DURATION);
    burgers = burgersList;
    notifyListeners();
  }

  setCurrentBurger(Burger burger) {
    currentBurger = burger;
    notifyListeners();
  }

  Future addToCart(BurgerOrder burgerOrder) async {
    await Future.delayed(Durations.REQUEST_DURATION);
    order.burgerOrders.add(burgerOrder);
    notifyListeners();
  }

  setOrderDate(DateTime dateTime) {
    order.dateTime = dateTime;
    notifyListeners();
  }

  setOrderTime(TimeOfDay timeOfDay) {
    DateTime orderDateTime = order.dateTime;
    order.dateTime = DateTime(orderDateTime.year, orderDateTime.month,
        orderDateTime.day, timeOfDay.hour, timeOfDay.minute);
    notifyListeners();
  }

  Future<List<AddressDescription>> findPlace(String input) async {
    String url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=${config.apiKey}';
    var jsonMap = await Requests.get(url, json: true);

    List<AddressDescription> descriptions = [];

    jsonMap["predictions"].forEach((prediction) {
      print(prediction);
      bool isValid = prediction["types"].firstWhere((elem) => elem == 'street_address', orElse: () => null) != null;
      descriptions.add(AddressDescription(id: prediction["id"], title: prediction["description"], isValid: isValid));
    });

    return descriptions;
  }

  setAddress(AddressDescription address) {
    order.address = address;
    notifyListeners();
  }

  int getTotalPrice() {
    int sum = 0;

    order.burgerOrders.forEach((burgerOrder) {
      sum += burgerOrder.burger.price;
    });

    return sum;
  }

  setOrderPayment(OrderPayment payment) {
    orderPayment = payment;
    notifyListeners();
  }
}
