import 'dart:math';

class Coordinates {
  double latitude;
  double longitude;

  Coordinates.fromGoogleResult(map) {
    var geometry = map['geometry'];
    var location = geometry['location'];
    var lat = location['lat'];
    var lng = location['lng'];
    latitude = lat + _getRandomAddition();
    longitude = lng + _getRandomAddition();
  }

  _getRandomAddition() {
    var r = Random();
    return r.nextBool() ? 0.1 : -0.1;
  }
}
