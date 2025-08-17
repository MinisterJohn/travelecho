import "package:dartz/dartz.dart";
import "package:dio/dio.dart";
import "package:logger/logger.dart";
import "package:shared_preferences/shared_preferences.dart";

import "../../service_provider_exports.dart";

class ServiceProviderRemoteSourceImpl extends ServiceProviderRemoteSource {
  final DioClient dio = sl<DioClient>();
  final Logger logger = Logger();
  final SharedPreferences _prefs = sl<SharedPreferences>();
  final ServiceProviderApiServiceUtils _utils;

  ServiceProviderRemoteSourceImpl() : _utils = ServiceProviderApiServiceUtils();
  @override
  Future<Either<String, String>> createServiceProvider(
    ServiceProviderParams params,
  ) async {
    try {
      final storedUserId = _prefs.getString('user_id');
      if (storedUserId == null || storedUserId.isEmpty) {
        logger.e("User ID is null or empty. Cannot create passport.");
        return const Left(
          'User ID is required to create a passport. Please log in again.',
        );
      }
      final options = await _utils.getOptions();
      final response = await dio.post(
        ApiUrl.dynamicServiceProviderURL(storedUserId),
        data: {"user": storedUserId, ...params.toJson()},
        options: options,
      );
      logger.i(
        "ServiceProvider created successfully: ${response.data["passport"]}",
      );
      return Right(response.data["message"]);
    } on DioException catch (e) {
      logger.e("Error creating passport: ${_utils.handleError(e)}");
      return Left(_utils.handleError(e));
    } catch (e) {
      logger.e("Unexpected error: $e");
      return Left("An unexpected error occurred: $e");
    }
  }
}
