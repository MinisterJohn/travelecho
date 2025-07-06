part of 'passport_bloc.dart';

abstract class TravelDocumentState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TravelDocumentInitial extends TravelDocumentState {}

class TravelDocumentLoading extends TravelDocumentState {}

class TravelDocumentSuccess extends TravelDocumentState {
  final TravelDocumentModel passport;

  TravelDocumentSuccess(this.passport);
  @override
  List<Object?> get props => [passport];
}

class TravelDocumentLoaded extends TravelDocumentState {
  final List<TravelDocumentModel> passports;
  TravelDocumentLoaded(this.passports);

  @override
  List<Object?> get props => [passports];
}

class TravelDocumentDetailLoaded extends TravelDocumentState {
  final TravelDocumentModel passport;
  TravelDocumentDetailLoaded(this.passport);

  @override
  List<Object?> get props => [passport];
}

class TravelDocumentImageUploaded extends TravelDocumentState {
  final String imageUrl;
  TravelDocumentImageUploaded(this.imageUrl);

  @override
  List<Object?> get props => [imageUrl];
}

class TravelDocumentError extends TravelDocumentState {
  final String message;
  TravelDocumentError(this.message);

  @override
  List<Object?> get props => [message];
}
