class CurrencyInfo {
  final String key;
  final String name;
  final String symbol;

  CurrencyInfo({required this.key,  required this.name, required this.symbol});

  factory CurrencyInfo.fromJson(Map<String, dynamic> json) {
    return CurrencyInfo(
      key: json['code'].toLowerCase(),
      name: json['name'],
      symbol: json['symbol'],
    );
  }
}
