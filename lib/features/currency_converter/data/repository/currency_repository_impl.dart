// ignore: file_names
import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';
import '../../currency_converter_exports.dart';

class CurrencyRepositoryImpl implements CurrencyRepository {
  final logger = Logger();
  final CurrencyRemoteSource remoteSource = sl<CurrencyRemoteSource>();
  @override
  Future<Either> getExchangeRates(String baseCurrency) async {
    try {
      final rates = await remoteSource.fetchExchangeRates(baseCurrency);
      logger.i("Exchange rates fetched successfully: ${rates.rates}"); // Log the rates
      return Right(rates); // ✅ Success
    } catch (e) {
      logger.e("Error fetching exchange rates: $e");
      return const Left("Failed to fetch exchange rates"); // ❌ Failure
    }
  }

  @override
  Future<Either<String, List<String>>> getCurrencyList() async {
    try {
      final currencies = await remoteSource.fetchCurrencyList();
      logger.i(currencies.currencies); // Log the currencies map
      return Right(currencies.toList()); // Convert to List<String> with symbols
    } catch (e) {
      logger.e("Error fetching currency list: $e");
      return const Left("Failed to get currency list"); // Handle failure
    }
  }
}
