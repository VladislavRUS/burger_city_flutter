import 'package:requests/requests.dart';

class Api {
  static Future<dynamic> findPlace(String input, String apiKey) async {
    String url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=$apiKey&types=address';
    return await Requests.get(url, json: true);
  }

  static Future<dynamic> getCoordinates(String address, String apiKey) async {
    String url =
        'https://maps.googleapis.com/maps/api/geocode/json?address=$address&key=$apiKey';

    return await Requests.get(url, json: true);
  }
}
