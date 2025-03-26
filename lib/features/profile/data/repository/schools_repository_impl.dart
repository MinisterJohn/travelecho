// ignore: file_names
import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';
import '../../profile_exports.dart';



class SchoolRepositoryImpl implements SchoolRepository {
  final logger = Logger();
  final SchoolRemoteSource remoteSource = sl<SchoolRemoteSource>();

  @override
  Future<Either<String, List<SchoolModel>>> getSchoolList(
      String schoolHint) async {
    try {
      final response = await remoteSource
          .fetchSchoolList(schoolHint); // API Response (List<Map>)
      final schoolModel = response; // ✅ Convert JSON list to model
      return Right(schoolModel.toList()); // ✅ Return List<SchoolModel>
    } catch (e, stackTrace) {
      logger.e("Error fetching school list: $e", stackTrace: stackTrace);
      return const Left("Failed to get school list");
    }
  }
}
