// ignore: file_names
import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';
import '../../profile_exports.dart';


class LocationRepositoryImpl implements LocationRepository {
  final logger = Logger();
  final LocationRemoteSource remoteSource = sl<LocationRemoteSource>();

  @override
  Future<Either<String, List<LocationModel>>> getLocationList(
      String locationHint) async {
    try {
      final response = await remoteSource
          .fetchLocationList(locationHint); // API Response (List<Map>)
      final locationModel = response; // ✅ Convert JSON list to model
      return Right(locationModel.toList()); // ✅ Return List<LocationModel>
    } catch (e, stackTrace) {
      logger.e("Error fetching location list: $e", stackTrace: stackTrace);
      return const Left("Failed to get location list");
    }
  }
}
