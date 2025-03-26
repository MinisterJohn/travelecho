class Currency {
  final String base;
  final Map<String, double> rates;

  Currency({required this.base, required this.rates});
}
class CurrencyList {
  final Map<String, String> currencies;

  CurrencyList({required this.currencies});
}
