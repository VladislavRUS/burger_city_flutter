import 'package:burger_city_flutter/constants/durations.dart';
import 'package:burger_city_flutter/models/burger.dart';
import 'package:burger_city_flutter/models/order.dart';
import 'package:scoped_model/scoped_model.dart';

List<Burger> burgersList = [
  Burger('assets/burgers/chiken_big.png', 'Chiken Big Burger', 380),
  Burger('assets/burgers/chiken_spicy.png', 'Chiken Spicy Burger', 320),
  Burger('assets/burgers/beef.png', 'Beef Burger', 420),
  Burger('assets/burgers/cheesy.png', 'Cheesy Burger', 290),
  Burger('assets/burgers/chiken_big.png', 'Chiken Big Burger', 380),
  Burger('assets/burgers/chiken_spicy.png', 'Chiken Spicy Burger', 320),
  Burger('assets/burgers/beef.png', 'Beef Burger', 420),
  Burger('assets/burgers/cheesy.png', 'Cheesy Burger', 290),
  Burger('assets/burgers/chiken_big.png', 'Chiken Big Burger', 380),
  Burger('assets/burgers/chiken_spicy.png', 'Chiken Spicy Burger', 320),
  Burger('assets/burgers/beef.png', 'Beef Burger', 420),
  Burger('assets/burgers/cheesy.png', 'Cheesy Burger', 290),
];

class Store extends Model {
  bool shouldRemember = false;
  List<Burger> burgers = [];
  Order currentOrder;

  toggleRemember() {
    shouldRemember = !shouldRemember;
    notifyListeners();
  }

  Future fetchBurgers() async {
    print('start fetch');
    await Future.delayed(Durations.REQUEST_DURATION);
    print('end fetch');
    burgers = burgersList;
    notifyListeners();
  }

  makeOrderFromBurger(Burger burger) {
    currentOrder = Order(burger);
    notifyListeners();
  }
}
