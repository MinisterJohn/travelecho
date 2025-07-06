import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../passport_exports.dart';

part 'passport_event.dart';
part 'passport_state.dart';

class TravelDocumentBloc
    extends Bloc<TravelDocumentEvent, TravelDocumentState> {
  final CreateTravelDocumentUseCase createTravelDocument =
      sl<CreateTravelDocumentUseCase>();
  final UpdateTravelDocumentUseCase updateTravelDocument =
      sl<UpdateTravelDocumentUseCase>();
  final DeleteTravelDocumentUseCase deleteTravelDocument =
      sl<DeleteTravelDocumentUseCase>();
  final GetAllTravelDocumentsUseCase getAllTravelDocuments =
      sl<GetAllTravelDocumentsUseCase>();
  final GetTravelDocumentByIdUseCase getTravelDocumentById =
      sl<GetTravelDocumentByIdUseCase>();
  final UploadTravelDocumentImagesUseCase uploadTravelDocumentImages =
      sl<UploadTravelDocumentImagesUseCase>();

  TravelDocumentBloc() : super(TravelDocumentInitial()) {
    on<CreateTravelDocumentEvent>((event, emit) async {
      emit(TravelDocumentLoading());
      final result = await createTravelDocument(event.params);
      result.fold(
        (l) => emit(TravelDocumentError(l)),
        (passport) => emit(TravelDocumentSuccess(passport)),
      );
    });

    on<UpdateTravelDocumentEvent>((event, emit) async {
      emit(TravelDocumentLoading());
      final result = await updateTravelDocument(event.id, event.params);
      result.fold(
        (l) => emit(TravelDocumentError(l)),
        (passport) => emit(TravelDocumentSuccess(passport)),
      );
    });

    on<DeleteTravelDocumentEvent>((event, emit) async {
      emit(TravelDocumentLoading());
      final result = await deleteTravelDocument(event.passportId);
      result.fold(
        (l) => emit(TravelDocumentError(l)),
        (r) => add(GetAllTravelDocumentsEvent(limit: 10, skip: 0)),
      );
    });

    on<GetAllTravelDocumentsEvent>((event, emit) async {
      emit(TravelDocumentLoading());
      final result = await getAllTravelDocuments(
        sort: event.sort,
        limit: event.limit,
        skip: event.skip,
      );
      result.fold(
        (l) => emit(TravelDocumentError(l)),
        (r) => emit(TravelDocumentLoaded(r)),
      );
    });

    on<GetTravelDocumentByIdEvent>((event, emit) async {
      emit(TravelDocumentLoading());
      final result = await getTravelDocumentById(event.id);
      result.fold(
        (l) => emit(TravelDocumentError(l)),
        (r) => emit(TravelDocumentDetailLoaded(r)),
      );
    });

    on<UploadTravelDocumentImagesEvent>((event, emit) async {
      emit(TravelDocumentLoading());
      final result = await uploadTravelDocumentImages(
        passportId: event.passportId,
        filePath: event.filePath,
      );
      result.fold(
        (l) => emit(TravelDocumentError(l)),
        (r) => add(GetAllTravelDocumentsEvent(limit: 10, skip: 0)),
      );
    });
  }
}
