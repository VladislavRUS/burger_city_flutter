import 'package:burger_city_flutter/constants/durations.dart';
import 'package:burger_city_flutter/models/address_description.dart';
import 'package:burger_city_flutter/models/available_locale.dart';
import 'package:burger_city_flutter/models/burger.dart';
import 'package:burger_city_flutter/models/combo.dart';
import 'package:burger_city_flutter/models/config.dart';
import 'package:burger_city_flutter/models/order.dart';
import 'package:burger_city_flutter/models/order_payment.dart';
import 'package:burger_city_flutter/models/product_order.dart';
import 'package:flutter/material.dart';
import 'package:requests/requests.dart';
import 'package:scoped_model/scoped_model.dart';

List<Burger> burgersList = [
  Burger(1, 380, 'Chiken Big Burger', 'assets/burgers/burger1.png'),
  Burger(2, 320, 'Chiken Spicy Burger', 'assets/burgers/burger2.png'),
  Burger(3, 420, 'Beef Burger', 'assets/burgers/burger3.png'),
  Burger(4, 290, 'Cheesy Burger', 'assets/burgers/burger4.png'),
  Burger(5, 380, 'Chiken Big Burger', 'assets/burgers/burger1.png'),
  Burger(6, 320, 'Chiken Spicy Burger', 'assets/burgers/burger2.png'),
  Burger(7, 420, 'Beef Burger', 'assets/burgers/burger3.png'),
  Burger(8, 290, 'Cheesy Burger', 'assets/burgers/burger4.png'),
  Burger(9, 380, 'Chiken Big Burger', 'assets/burgers/burger1.png'),
  Burger(10, 320, 'Chiken Spicy Burger', 'assets/burgers/burger2.png'),
  Burger(11, 420, 'Beef Burger', 'assets/burgers/burger3.png'),
  Burger(12, 290, 'Cheesy Burger', 'assets/burgers/burger4.png'),
];

List<Combo> combosList = [
  Combo(
      1, 100, 'Super Chiken', 'assets/offers/offer1.png', [burgersList.first]),
  Combo(2, 180, 'Super Beef', 'assets/offers/offer2.png', [burgersList[2]]),
  Combo(3, 250, 'Super Cheesy', 'assets/offers/offer3.png', [burgersList.last]),
];

List<AvailableLocale> availableLocalesList = [
  AvailableLocale(
      name: 'Русский',
      languageCode: 'ru',
      countryCode: 'RU',
      icon: 'assets/icons/ru-flag.png'),
  AvailableLocale(
      name: 'English',
      languageCode: 'en',
      countryCode: 'EN',
      icon: 'assets/icons/en-flag.png'),
];

class Store extends Model {
  bool shouldRemember = false;
  List<Burger> burgers = [];
  List<Combo> combos = [];
  Burger currentBurger;
  Combo currentCombo;
  OrderPayment orderPayment;
  Order order;
  Config config;
  Locale locale;
  List<AvailableLocale> availableLocales;

  Store({this.config}) {
    availableLocales = availableLocalesList;
    AvailableLocale availableLocale = availableLocales.first;
    locale = Locale(availableLocale.languageCode, availableLocale.countryCode);
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

  Future fetchCombos() async {
    await Future.delayed(Durations.REQUEST_DURATION);
    combos = combosList;
    notifyListeners();
  }

  setCurrentBurger(Burger burger) {
    currentBurger = burger;
    currentCombo = null;
    notifyListeners();
  }

  setCurrentCombo(Combo combo) {
    currentCombo = combo;
    currentBurger = null;
    notifyListeners();
  }

  Future addToCart(ProductOrder productOrder) async {
    if (order == null) {
      order = Order();
    }

    await Future.delayed(Durations.REQUEST_DURATION);
    order.addProductOrder(productOrder);
    notifyListeners();
  }

  Future clearCart() async {
    await Future.delayed(Durations.REQUEST_DURATION);
    order = Order();
    notifyListeners();
  }

  setOrderDateTime(DateTime dateTime) {
    order.dateTime = dateTime;
    notifyListeners();
  }

  Future<List<AddressDescription>> findPlace(String input) async {
    String url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=${config.apiKey}';
    var jsonMap = await Requests.get(url, json: true);

    List<AddressDescription> descriptions = [];

    jsonMap["predictions"].forEach((prediction) {
      var streetPrediction = prediction["types"]
          .firstWhere((elem) => elem == 'street_address', orElse: () => null);

      var isPredictionValid = streetPrediction != null;

      descriptions.add(AddressDescription(
          id: prediction["id"],
          title: prediction["description"],
          isValid: isPredictionValid));
    });

    return descriptions;
  }

  Future<Map<String, double>> getCoordinates(String address) async {
    String url =
        'https://maps.googleapis.com/maps/api/geocode/json?address=$address&key=${config.apiKey}';

    var jsonMap = await Requests.get(url, json: true);
    var result = jsonMap['results'][0];
    var geometry = result['geometry'];
    var location = geometry['location'];
    var lat = location['lat'];
    var lng = location['lng'];

    return { 'latitude': lat + 0.01, 'longitude': lng + 0.01 };
  }

  setAddress(AddressDescription addressDescription) {
    order.addressDescription = addressDescription;
    notifyListeners();
  }

  int getTotalPrice() {
    int sum = 0;

    order.productOrders.forEach((productOrder) {
      sum += productOrder.product.price;
    });

    return sum;
  }

  setOrderPayment(OrderPayment payment) {
    orderPayment = payment;
    notifyListeners();
  }

  setLocale(Locale newLocale) {
    locale = newLocale;
    notifyListeners();
  }
}
