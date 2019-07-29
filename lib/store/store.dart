import 'package:burger_city_flutter/constants/durations.dart';
import 'package:burger_city_flutter/models/burger.dart';
import 'package:burger_city_flutter/models/burger_order.dart';
import 'package:burger_city_flutter/models/order.dart';
import 'package:flutter/src/material/time.dart';
import 'package:scoped_model/scoped_model.dart';

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
  bool shouldRemember = false;
  List<Burger> burgers = [];
  Burger currentBurger;
  Order order = Order();

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
}
