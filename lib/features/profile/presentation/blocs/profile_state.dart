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
            dob: DateTime.now(),
            interests: const <InterestModel>[],
            location: "",
            school: const SchoolModel(name: "", country: ""),
            occupation: "",
            languages: const <LanguageModel>[],
          ),
        );
}

enum ProfileUpdateKey { location, dob, school, occupation, interests, languages }

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
