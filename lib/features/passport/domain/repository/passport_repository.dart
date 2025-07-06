import 'package:dartz/dartz.dart';
import '../../passport_exports.dart';
// import '../../usecases/passport_params.dart';

abstract class TravelDocumentRepository {
  Future<Either<String, TravelDocumentModel>> createTravelDocument(
    TravelDocumentParams passport,
  );

  Future<Either<String, TravelDocumentModel>> updateTravelDocument(
    String id,
    TravelDocumentParams passport,
  );

  Future<Either<String, void>> deleteTravelDocument(String id);

  Future<Either<String, List<TravelDocumentModel>>> getAllTravelDocuments({
    String? sort,
    required int limit,
    required int skip,
  });

  Future<Either<String, TravelDocumentModel>> getTravelDocumentById(String id);

  Future<Either<String, String>> uploadTravelDocumentImages({
    required String passportId,
    required dynamic filePath,
  });
}
