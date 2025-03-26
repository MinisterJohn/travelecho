import 'package:dartz/dartz.dart';
import 'package:travelecho/features/profile/data/models/location_list_model.dart';
import 'package:travelecho/service_locator.dart';
import '../repository/locations_repository.dart';

class GetLocationList {
  Future<Either<String, List<LocationModel>>> getList(String locationHint) async {
    final result = await sl<LocationRepository>().getLocationList(locationHint);

    return result.fold(
      (failure) => Left(failure), // ❌ If API fails
      (locations) {
        return Right(locations.toList()); // ✅ Success
      },
    );
  }
}
