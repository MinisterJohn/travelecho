import 'package:dartz/dartz.dart';
import '../../profile_exports.dart';


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
