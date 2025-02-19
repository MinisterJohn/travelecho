import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:travelecho/core/network/dio_client.dart';
import 'package:travelecho/features/currency_converter/data/models/currencies_list_model.dart';
import 'package:travelecho/service_locator.dart';
import '../models/currency_model.dart';

abstract class CurrencyRemoteSource {
  Future<CurrencyModel> fetchExchangeRates(String baseCurrency);
  Future<CurrencyListModel> fetchCurrencyList();
}

class CurrencyRemoteSourceImpl extends CurrencyRemoteSource {
  final Dio dio = Dio();
  @override
  Future<CurrencyModel> fetchExchangeRates(String baseCurrency) async {
    final response = await dio.get(
        "https://cdn.jsdelivr.net/npm/@fawazahmed0/currency-api@latest/v1/currencies/$baseCurrency.json");

    if (response.statusCode == 200) {
    Logger().d("COnvert API Response: ${response.data}");

      return CurrencyModel.fromJson(response.data, baseCurrency);
    } else {
      throw Exception("Failed to load exchange rates");
    }
  }

  @override
  Future<CurrencyListModel> fetchCurrencyList() async {
    final response = await dio.get(
        "https://cdn.jsdelivr.net/npm/@fawazahmed0/currency-api@latest/v1/currencies.json");
    Logger().d("Currency API Response: ${response.data}");
    if (response.statusCode == 200) {
      return CurrencyListModel.fromJson(response.data);
    } else {
      throw Exception("Failed to get currencies");
    }
  }
}
