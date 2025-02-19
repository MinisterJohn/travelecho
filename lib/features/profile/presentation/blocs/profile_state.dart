abstract class ProfileState {
  final Map<String, String> profile;
  ProfileState(this.profile);
}

class ProfileInitial extends ProfileState {
  ProfileInitial()
      : super({
          "location": "",
          "dob": "",
          "school": "",
        });
}

class ProfileLoading extends ProfileState {
  ProfileLoading() : super({});
}

class ProfileLoaded extends ProfileState {
  ProfileLoaded(super.profile);
}

class ProfileUpdated extends ProfileState {
  ProfileUpdated(profile, String key, String value)
      : super({...profile, key: value}); // Merge old profile and update key
}
