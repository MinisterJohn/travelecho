import 'package:dartz/dartz.dart';
import '../../passport_exports.dart';

class TravelDocumentRepositoryImpl implements TravelDocumentRepository {
  final TravelDocumentRemoteDataSource remoteDataSource =
      sl<TravelDocumentRemoteDataSource>();

  TravelDocumentRepositoryImpl();

  @override
  Future<Either<String, TravelDocumentModel>> createTravelDocument(
    TravelDocumentParams passport,
  ) {
    return remoteDataSource.createTravelDocument(passport);
  }

  @override
  Future<Either<String, TravelDocumentModel>> updateTravelDocument(
    String id,
    TravelDocumentParams passport,
  ) {
    return remoteDataSource.updateTravelDocument(id, passport);
  }

  @override
  Future<Either<String, void>> deleteTravelDocument(String id) {
    return remoteDataSource.deleteTravelDocument(id);
  }

  @override
  Future<Either<String, List<TravelDocumentModel>>> getAllTravelDocuments({
    String? sort,
    required int limit,
    required int skip,
  }) {
    return remoteDataSource.getAllTravelDocuments(
      sort: sort,
      limit: limit,
      skip: skip,
    );
  }

  @override
  Future<Either<String, TravelDocumentModel>> getTravelDocumentById(String id) {
    return remoteDataSource.getTravelDocumentById(id);
  }

  @override
  Future<Either<String, String>> uploadTravelDocumentImages({
    required String passportId,
    required dynamic filePath,
  }) {
    return remoteDataSource.uploadTravelDocumentImages(
      passportId: passportId,
      filePath: filePath,
    );
  }
}
