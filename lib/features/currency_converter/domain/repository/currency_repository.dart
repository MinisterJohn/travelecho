import 'package:dartz/dartz.dart';

abstract class CurrencyRepository {
  Future<Either> getExchangeRates(String baseCurrency);
  Future<Either> getCurrencyList();
}
