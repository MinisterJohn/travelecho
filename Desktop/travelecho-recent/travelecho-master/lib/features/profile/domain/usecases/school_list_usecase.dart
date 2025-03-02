import 'package:dartz/dartz.dart';
import 'package:travelecho/features/profile/data/models/schools_list_model.dart';
import 'package:travelecho/service_locator.dart';
import '../repository/schools_repository.dart';

class GetSchoolList {
  Future<Either<String, List<SchoolModel>>> getList(String schoolHint) async {
    final result = await sl<SchoolRepository>().getSchoolList(schoolHint);

    return result.fold(
      (failure) => Left(failure), // ❌ If API fails
      (schools) {
        return Right(schools.toList()); // ✅ Success
      },
    );
  }
}
