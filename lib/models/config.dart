class Config {
  String apiKey;

  Config.fromJson(map) {
    apiKey = map['apiKey'];
  }
}
