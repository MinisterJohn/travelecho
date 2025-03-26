class CurrencyListModel {
  final Map<String, String> currencies;

  CurrencyListModel({required this.currencies});

  factory CurrencyListModel.fromJson(Map<String, dynamic> json) {
    return CurrencyListModel(currencies: Map<String, String>.from(json));
  }

  /// Convert the map into a formatted List<String>
  List<String> toList() {
    return currencies.entries.map((e) => "${e.key.toUpperCase()} - ${e.value}").toList();
  }
}
