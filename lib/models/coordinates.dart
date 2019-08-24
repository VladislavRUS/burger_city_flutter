class Coordinates {
  double latitude;
  double longitude;

  Coordinates.fromGoogleResult(map) {
    var geometry = map['geometry'];
    var location = geometry['location'];
    var lat = location['lat'];
    var lng = location['lng'];
    latitude = lat + 0.1;
    longitude = lng + 0.1;
  }
}
