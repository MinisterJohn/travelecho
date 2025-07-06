import 'package:dartz/dartz.dart';
import '../../passport_exports.dart';

class CreateTravelDocumentUseCase {
  final TravelDocumentRepository repository = sl<TravelDocumentRepository>();
  CreateTravelDocumentUseCase();

  Future<Either<String, TravelDocumentModel>> call(
    TravelDocumentParams params,
  ) {
    return repository.createTravelDocument(params);
  }
}

class UpdateTravelDocumentUseCase {
  final TravelDocumentRepository repository = sl<TravelDocumentRepository>();
  UpdateTravelDocumentUseCase();

  Future<Either<String, TravelDocumentModel>> call(
    String id,
    TravelDocumentParams params,
  ) {
    return repository.updateTravelDocument(id, params);
  }
}

class DeleteTravelDocumentUseCase {
  final TravelDocumentRepository repository = sl<TravelDocumentRepository>();
  DeleteTravelDocumentUseCase();

  Future<Either<String, void>> call(String id) {
    return repository.deleteTravelDocument(id);
  }
}

class GetAllTravelDocumentsUseCase {
  final TravelDocumentRepository repository = sl<TravelDocumentRepository>();
  GetAllTravelDocumentsUseCase();

  Future<Either<String, List<TravelDocumentModel>>> call({
    String? sort,
    required int limit,
    required int skip,
  }) {
    return repository.getAllTravelDocuments(
      sort: sort,
      limit: limit,
      skip: skip,
    );
  }
}

class GetTravelDocumentByIdUseCase {
  final TravelDocumentRepository repository = sl<TravelDocumentRepository>();
  GetTravelDocumentByIdUseCase();

  Future<Either<String, TravelDocumentModel>> call(String id) {
    return repository.getTravelDocumentById(id);
  }
}

class UploadTravelDocumentImagesUseCase {
  final TravelDocumentRepository repository = sl<TravelDocumentRepository>();
  UploadTravelDocumentImagesUseCase();

  Future<Either<String, String>> call({
    required String passportId,
    required dynamic filePath,
  }) {
    return repository.uploadTravelDocumentImages(
      passportId: passportId,
      filePath: filePath,
    );
  }
}
