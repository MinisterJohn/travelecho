abstract class ProfileEvent {}

class ProfileRequested extends ProfileEvent {}

class ProfileUpdateRequested extends ProfileEvent {
  final String key;
  final String value;
  ProfileUpdateRequested(this.key, this.value);
}
