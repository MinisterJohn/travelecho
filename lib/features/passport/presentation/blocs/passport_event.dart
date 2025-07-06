part of 'passport_bloc.dart';

abstract class TravelDocumentEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreateTravelDocumentEvent extends TravelDocumentEvent {
  final TravelDocumentParams params;
  CreateTravelDocumentEvent(this.params);

  @override
  List<Object?> get props => [params];
}

class UpdateTravelDocumentEvent extends TravelDocumentEvent {
  final String id;
  final TravelDocumentParams params;
  UpdateTravelDocumentEvent(this.id, this.params);

  @override
  List<Object?> get props => [id, params];
}

class DeleteTravelDocumentEvent extends TravelDocumentEvent {
  final String passportId;
  DeleteTravelDocumentEvent(this.passportId);

  @override
  List<Object?> get props => [passportId];
}

class GetAllTravelDocumentsEvent extends TravelDocumentEvent {
  final String? sort;
  final int limit;
  final int skip;
  GetAllTravelDocumentsEvent({
    this.sort,
    required this.limit,
    required this.skip,
  });

  @override
  List<Object?> get props => [sort, limit, skip];
}

class GetTravelDocumentByIdEvent extends TravelDocumentEvent {
  final String id;
  GetTravelDocumentByIdEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class UploadTravelDocumentImagesEvent extends TravelDocumentEvent {
  final String passportId;
  final dynamic filePath;
  UploadTravelDocumentImagesEvent({
    required this.passportId,
    required this.filePath,
  });

  @override
  List<Object?> get props => [passportId, filePath];
}
