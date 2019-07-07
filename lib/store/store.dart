import 'package:scoped_model/scoped_model.dart';

class Store extends Model {
  bool shouldRemember = false;

  toggleRemember() {
    shouldRemember = !shouldRemember;
    notifyListeners();
  }
}
