import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';
import '../../currency_converter_exports.dart';

abstract class CurrencyRemoteSource {
  Future<CurrencyModel> fetchExchangeRates(String baseCurrency);
  Future<CurrencyListModel> fetchCurrencyList();
  Future<List<CurrencyInfo>> fetchMergedCurrencyList(BuildContext context);
}

class CurrencyRemoteSourceImpl extends CurrencyRemoteSource {
  final Dio dio = Dio();

  @override
  Future<CurrencyModel> fetchExchangeRates(String baseCurrency) async {
    final response = await dio.get(
      "https://cdn.jsdelivr.net/npm/@fawazahmed0/currency-api@latest/v1/currencies/$baseCurrency.json",
    );

    try {
      Logger().d("fetchExchangeRates - Response: ${response.data}");
      return CurrencyModel.fromJson(response.data, baseCurrency);
    } catch (e) {
      Logger().e("fetchExchangeRates - Error: ${e.toString()}");
      throw Exception("Failed to load exchange rates ${e.toString()}");
    }
  }

  @override
  Future<CurrencyListModel> fetchCurrencyList() async {
    final response = await dio.get(
      "https://cdn.jsdelivr.net/npm/@fawazahmed0/currency-api@latest/v1/currencies.json",
    );
    Logger().d("Currency API Response: ${response.data}");
    if (response.statusCode == 200) {
      return CurrencyListModel.fromJson(response.data);
    } else {
      throw Exception("Failed to get currencies");
    }
  }

  /// ✅ This method merges API data with local JSON symbol data
  @override
  Future<List<CurrencyInfo>> fetchMergedCurrencyList(
    BuildContext context,
  ) async {
    try {
      // Logger().d("Fetching merged currency list...");

      // Load remote data
      final response = await dio.get(
        "https://cdn.jsdelivr.net/npm/@fawazahmed0/currency-api@latest/v1/currencies.json",
      );
      // Logger().d("Remote API Response: ${response.data}");

      // Fixed the undefined 'apiData' issue by ensuring it is assigned correctly
      final Map<String, dynamic> apiData =
          response.data as Map<String, dynamic>;
      // Logger().d("Remote API Data: $apiData");

      // Load local JSON data
      final jsonString = await DefaultAssetBundle.of(
        context,
      ).loadString("assets/json/currencies.json");
      // Logger().d("Local JSON Data: $jsonString");
      final List localList = json.decode(jsonString);

      final Map<String, CurrencyInfo> localMap = {
        for (var e in localList)
          CurrencyInfo.fromJson(e).key.toLowerCase(): CurrencyInfo.fromJson(e),
      };

      final List<CurrencyInfo> merged = [];

      for (final entry in apiData.entries) {
        final key = entry.key.toLowerCase();
        final name = entry.value;

        if (localMap.containsKey(key)) {
          merged.add(localMap[key]!);
        } else {
          merged.add(CurrencyInfo(key: key, name: name, symbol: ''));
        }
      }
      // Logger().d("Merged Currency List: $merged");

      return merged;
    } catch (e) {
      Logger().e("fetchMergedCurrencyList - Error: $e");
      throw Exception("Failed to load merged currency data");
    }
  }
}
