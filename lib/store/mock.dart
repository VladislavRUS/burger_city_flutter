import 'package:burger_city_flutter/models/address_description.dart';
import 'package:burger_city_flutter/models/available_locale.dart';
import 'package:burger_city_flutter/models/burger.dart';
import 'package:burger_city_flutter/models/combo.dart';
import 'package:burger_city_flutter/models/drink.dart';
import 'package:burger_city_flutter/models/order_payment.dart';
import 'package:burger_city_flutter/models/snack.dart';

class Mock {
  static List<Burger> burgers = [
    Burger(1, 13, 'burgers.burger_1', 'assets/burgers/burger_1.png'),
    Burger(2, 15, 'burgers.burger_2', 'assets/burgers/burger_2.png'),
    Burger(3, 11, 'burgers.burger_3', 'assets/burgers/burger_3.png'),
    Burger(4, 10, 'burgers.burger_4', 'assets/burgers/burger_4.png'),
    Burger(5, 19, 'burgers.burger_5', 'assets/burgers/burger_5.png'),
    Burger(6, 18, 'burgers.burger_6', 'assets/burgers/burger_6.png'),
    Burger(7, 15, 'burgers.burger_7', 'assets/burgers/burger_7.png'),
    Burger(8, 12, 'burgers.burger_8', 'assets/burgers/burger_8.png'),
  ];

  static List<Snack> snacks = [
    Snack(1, 50, 'snacks.snack_1', 'assets/snacks/fries_1.jpg'),
    Snack(2, 30, 'snacks.snack_2', 'assets/snacks/fries_2.jpg'),
  ];

  static List<Drink> drinks = [
    Drink(1, 25, 'drinks.drink_1', 'assets/drinks/cola_1.png'),
  ];

  static List<Combo> combos = [
    Combo(1, 100, 'combos.combo_1', 'assets/combos/combo_1.jpg',
        [burgers[0], snacks.first, drinks.first]),
    Combo(2, 180, 'combos.combo_2', 'assets/combos/combo_2.jpg',
        [burgers[1], snacks.last, drinks.first]),
    Combo(3, 250, 'combos.combo_3', 'assets/combos/combo_3.jpg',
        [burgers[2], snacks.first, drinks.first]),
    Combo(4, 250, 'combos.combo_4', 'assets/combos/combo_4.jpg',
        [burgers[3], snacks.last, drinks.first]),
  ];

  static List<AvailableLocale> availableLocales = [
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

  static List<OrderPayment> orderPayments = [
    OrderPayment(name: 'M Wallet'),
    OrderPayment(name: 'Google Pay'),
    OrderPayment(name: 'Apple Pay'),
    OrderPayment(name: 'Samsung Pay '),
  ];

  static List<AddressDescription> addressDescriptions = [
    AddressDescription('129348', '129348, Москва, ул.Красная Сосна, 33, кв.33', true),
    AddressDescription('115516', '115516, Москва, ул.Товарищеская, 91, кв.15', true),
    AddressDescription('109316', '109316, Москва, ул.Стройковская, 78, кв.46', true),
  ];
}
