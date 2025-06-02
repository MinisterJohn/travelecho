part of "profile_bloc.dart";

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}
class ProfileUpdating extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final Profile profile;

  const ProfileLoaded(this.profile);

  @override
  List<Object?> get props => [profile];
}

class ProfileImageUploading extends ProfileState {
  final Profile profile;

  const ProfileImageUploading(this.profile);

  @override
  List<Object?> get props => [profile];
}

class ProfileImageUploaded extends ProfileState {
  final Profile profile;
  final String imageUrl;

  const ProfileImageUploaded(this.profile, this.imageUrl);

  @override
  List<Object?> get props => [profile, imageUrl];
}

class ProfileFailure extends ProfileState {
  final String error;
  final Profile? profile;

  const ProfileFailure(this.error, [this.profile]);

  @override
  List<Object?> get props => [error, profile];
}
