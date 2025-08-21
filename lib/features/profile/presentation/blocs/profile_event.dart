part of "profile_bloc.dart";

enum ProfileUpdateKey {
  name,
  dateOfBirth,
  location,
  school,
  occupation,
  interests,
  languages
}

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class ProfileLoadRequested extends ProfileEvent {}

class ProfileUpdateRequested extends ProfileEvent {
  final dynamic updateValue;
  final ProfileUpdateKey updateKey;
  const ProfileUpdateRequested(this.updateValue, this.updateKey);

  @override
  List<Object?> get props => [updateValue, updateKey];
}

class ProfileImageUpdateRequested extends ProfileEvent {
  final FormData formData;

  const ProfileImageUpdateRequested(this.formData);

  @override
  List<Object?> get props => [formData];
}
