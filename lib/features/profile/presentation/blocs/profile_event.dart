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
  final dynamic imageFile;

  const ProfileImageUpdateRequested(this.imageFile);

  @override
  List<Object?> get props => [imageFile];
}
