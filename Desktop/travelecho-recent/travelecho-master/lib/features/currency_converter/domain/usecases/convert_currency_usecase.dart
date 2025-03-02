import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';
import 'package:travelecho/service_locator.dart';
import '../repository/currency_repository.dart';

class ConvertCurrency {
  Future<Either<String, List<double>>> execute(
      String base, String target, double amount) async {
    final result = await sl<CurrencyRepository>().getExchangeRates(base);

    return result.fold(
      (failure) => Left(failure), // ❌ If API fails
      (currency) {
        if (currency.rates.containsKey(target)) {
          double convertedAmount = amount * currency.rates[target]!;
          Logger().d("Converted amount: $convertedAmount");
          return Right([currency.rates[target], convertedAmount]); // ✅ Success
        } else {
          return const Left("Currency not found");
        }
      },
    );
  }
}

class GetCurrencyList {
  Future<Either<String, List<String>>> getList() async {
    final result = await sl<CurrencyRepository>().getCurrencyList();

    return result.fold(
      (failure) => Left(failure), // ❌ If API fails
      (currencies) {
        return Right(currencies.toList()); // ✅ Success
      },
    );
  }
}
