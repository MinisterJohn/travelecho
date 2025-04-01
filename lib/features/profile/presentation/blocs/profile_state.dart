part of "profile_bloc.dart";

abstract class ProfileState extends Equatable {
  final Profile profile;
  const ProfileState({required this.profile});

  @override
  List<Object?> get props => [profile];
}

class ProfileInitial extends ProfileState {
  ProfileInitial()
      : super(
          profile: Profile(
            image: "",
            dob: DateTime.now(),
            interests: const <String>[],
            location: "",
            school: const SchoolModel(name: "", country: ""),
            occupation: "",
            languages: const <String>[],
          ),
        );
}

enum ProfileUpdateKey {
  location,
  dob,
  school,
  occupation,
  interests,
  languages,
  image
}

class ProfileLoading extends ProfileState {
  const ProfileLoading({required super.profile});
}

class ProfileLoaded extends ProfileState {
  const ProfileLoaded({required super.profile});
}

class ProfileUpdated extends ProfileState {
  final ProfileUpdateKey updateKey;

  const ProfileUpdated({required super.profile, required this.updateKey});
  @override
  List<Object?> get props => [profile, updateKey];
}

class ProfileFailure extends ProfileState {
  final String error;

  ProfileFailure(this.error)
      : super(
            profile: Profile(
          image: "",
          dob: DateTime.now(),
          interests: const <String>[],
          location: "",
          school: const SchoolModel(name: "", country: ""),
          occupation: "",
          languages: const <String>[],
        ));

  @override
  List<Object?> get props => [profile, error];
}
