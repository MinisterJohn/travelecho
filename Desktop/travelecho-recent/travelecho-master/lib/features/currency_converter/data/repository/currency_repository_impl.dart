// ignore: file_names
import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';
import 'package:travelecho/service_locator.dart';
import '../../domain/repository/currency_repository.dart';
import '../sources/currency_remote_source.dart';

class CurrencyRepositoryImpl implements CurrencyRepository {
  final logger = Logger();
  final CurrencyRemoteSource remoteSource = sl<CurrencyRemoteSource>();
  @override
  Future<Either> getExchangeRates(String baseCurrency) async {
    try {
      final rates = await remoteSource.fetchExchangeRates(baseCurrency);
      return Right(rates); // ✅ Success
    } catch (e) {
      logger.e("Error fetching exchange rates: $e");
      return const Left("Failed to fetch exchange rates"); // ❌ Failure
    }
  }

  @override
  Future<Either<String, List<String>>> getCurrencyList() async {
    try {
      final currencies = await remoteSource
          .fetchCurrencyList(); // Assuming this returns CurrencyListModel
      return Right(currencies.toList()); // ✅ Convert to List<String>
    } catch (e) {
      logger.e("Error fetching exchange rates: $e");
      return const Left("Failed to get currency list"); // ❌ Handle failure
    }
  }
}
