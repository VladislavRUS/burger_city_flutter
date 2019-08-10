class AddressDescription {
  String id;
  String title;
  bool isValid;

  AddressDescription(this.id, this.title, this.isValid);

  AddressDescription.fromJson(map) {
    id = map["id"];
    title = map["title"];

    var streetPrediction = map["types"]
        .firstWhere((elem) => elem == 'street_address', orElse: () => null);
    isValid = streetPrediction != null;
  }
}
