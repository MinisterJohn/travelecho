import 'package:dartz/dartz.dart';
import '../../service_provider_exports.dart';

abstract class ServiceProviderRemoteSource {
  Future<Either<String, String>> createServiceProvider(
    ServiceProviderParams passport,
  );
}
