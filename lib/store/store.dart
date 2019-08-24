import 'package:burger_city_flutter/api/api.dart';
import 'package:burger_city_flutter/constants/durations.dart';
import 'package:burger_city_flutter/models/address_description.dart';
import 'package:burger_city_flutter/models/available_locale.dart';
import 'package:burger_city_flutter/models/burger.dart';
import 'package:burger_city_flutter/models/combo.dart';
import 'package:burger_city_flutter/models/config.dart';
import 'package:burger_city_flutter/models/coordinates.dart';
import 'package:burger_city_flutter/models/order.dart';
import 'package:burger_city_flutter/models/order_payment.dart';
import 'package:burger_city_flutter/models/product_order.dart';
import 'package:burger_city_flutter/store/mock.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class Store extends Model {
  bool shouldRemember = false;
  Burger currentBurger;
  Combo currentCombo;
  OrderPayment orderPayment;
  Order order;
  Order confirmedOrder;
  Config config;
  Locale locale;
  List<Burger> burgers = [];
  List<Combo> combos = [];
  List<AvailableLocale> availableLocales;
  List<OrderPayment> orderPayments;

  Store({this.config}) {
    combos = Mock.combos;
    availableLocales = Mock.availableLocales;
    burgers = Mock.burgers;
    orderPayments = Mock.orderPayments;
    order = Order();
    orderPayment = orderPayments.first;
    AvailableLocale availableLocale = availableLocales.first;
    locale = Locale(availableLocale.languageCode, availableLocale.countryCode);
  }

  toggleRemember() {
    shouldRemember = !shouldRemember;
    notifyListeners();
  }

  Future fetchBurgers() async {
    await Future.delayed(Durations.REQUEST_DURATION);
    burgers = Mock.burgers;
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
    await Future.delayed(Durations.REQUEST_DURATION);

    if (confirmedOrder != null) {
      confirmedOrder = null;
    }

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
    List<AddressDescription> descriptions = [];

    var jsonMap = await Api.findPlace(input, config.apiKey);
    var predictions = jsonMap["predictions"];

    predictions.forEach((prediction) {
      descriptions.add(AddressDescription.fromJson(prediction));
    });

    return descriptions;
  }

  Future<Coordinates> getCoordinates(String address) async {
    var jsonMap = await Api.getCoordinates(address, config.apiKey);
    var result = jsonMap['results'][0];
    return Coordinates.fromGoogleResult(result);
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

  confirmOrder() async {
    await Future.delayed(Durations.REQUEST_DURATION);
    order.isConfirmed = true;
    confirmedOrder = Order.fromOrder(order);

    order = Order();

    notifyListeners();
  }
}
