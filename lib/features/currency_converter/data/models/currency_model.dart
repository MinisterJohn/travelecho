class CurrencyModel {
  final String base;
  final Map<String, double> rates;

  CurrencyModel({required this.base, required this.rates});

  factory CurrencyModel.fromJson(Map<String, dynamic> json, String base) {
    return CurrencyModel(
      base: base,
      rates: Map<String, double>.from(json[base]),
    );
  }
}
