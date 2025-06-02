import 'package:logger/logger.dart';

class CurrencyModel {
  final String base;
  final Map<String, double> rates;

  CurrencyModel({required this.base, required this.rates});

  factory CurrencyModel.fromJson(Map<String, dynamic> json, String base) {
    final baseData = json[base];
    if (baseData is! Map<String, dynamic>) {
      Logger().e("Unexpected format for base data: $baseData");
      throw Exception("Invalid format for base data");
    }

    Logger().d("CurrencyModel.fromJson - Base: $base, JSON: $baseData");
    return CurrencyModel(
      base: base,
      rates: baseData
          .map((key, value) => MapEntry(key, (value as num).toDouble())),
    );
  }
}
