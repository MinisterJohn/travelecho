part of "profile_bloc.dart";

abstract class ProfileEvent extends Equatable {}

class ProfileRequested extends ProfileEvent {
  final String profileId;
  ProfileRequested(this.profileId);

  @override
  List<Object?> get props => [profileId];
}

class ProfileUpdateRequested extends ProfileEvent {
  final dynamic updateValue;
  final ProfileUpdateKey updateKey;
  ProfileUpdateRequested(this.updateValue, this.updateKey);

  @override
  List<Object?> get props => [updateValue, updateKey];
}
