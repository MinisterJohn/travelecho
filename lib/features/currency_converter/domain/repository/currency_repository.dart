import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';

abstract class CurrencyRepository {
  Future<Either> getExchangeRates(String baseCurrency);
  Future<Either> getCurrencyList();
  Future<Either> getMergedCurrencyList(BuildContext context);
}
