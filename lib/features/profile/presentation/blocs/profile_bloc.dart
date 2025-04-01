import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../profile_exports.dart';

part "profile_state.dart";
part "profile_event.dart";

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileApiService _profileApiService;
  final SharedPreferences _prefs;
  Profile profile = Profile(
    location: "",
    image: "",
    dob: DateTime.now(),
    school: const SchoolModel(country: "", name: ""),
    occupation: "",
    interests: const <String>[],
    languages: const <String>[],
  );

  String profileId = "";

  ProfileBloc(this._profileApiService, this._prefs) : super(ProfileInitial()) {
    on<ProfileRequested>((event, emit) async {
      try {
        emit(ProfileLoading(profile: profile));

        profileId = event.profileId;

        final result = await _profileApiService.getProfile(profileId);
        result.fold(
          (error) => emit(ProfileFailure(error)),
          (data) {
            final profileData = data['data'];
            profile = Profile(
              location: profileData['location'] ?? "",
              image: profileData['image'] ?? "",
              dob: DateTime.parse(profileData['dateOfBirth'] ??
                  DateTime.now().toIso8601String()),
              school: SchoolModel(
                country: profileData['school']?['country'] ?? "",
                name: profileData['school']?['name'] ?? "",
              ),
              occupation: profileData['occupation'] ?? "",
              interests: List<String>.from(profileData['interests'] ?? []),
              languages: List<String>.from(profileData['languages'] ?? []),
            );
            emit(ProfileLoaded(profile: profile));
          },
        );
      } catch (e) {
        emit(ProfileFailure(e.toString()));
      }
    });

    on<ProfileUpdateRequested>((event, emit) async {
      try {
        emit(ProfileLoading(profile: profile));

        // Use copyWith to create a new updated profile instance
        Profile updatedProfile = profile.copyWith(
          location: event.updateKey == ProfileUpdateKey.location
              ? event.updateValue
              : profile.location,
          dob: event.updateKey == ProfileUpdateKey.dob
              ? event.updateValue
              : profile.dob,
          school: event.updateKey == ProfileUpdateKey.school
              ? event.updateValue as SchoolModel
              : profile.school,
          occupation: event.updateKey == ProfileUpdateKey.occupation
              ? event.updateValue
              : profile.occupation,
          interests: event.updateKey == ProfileUpdateKey.interests
              ? _updateInterests(profile.interests, event.updateValue as String)
              : profile.interests,
          languages: event.updateKey == ProfileUpdateKey.languages
              ? _updateLanguages(profile.languages, event.updateValue as String)
              : profile.languages,
          image: event.updateKey == ProfileUpdateKey.image
              ? event.updateValue
              : profile.image,
        );

        // Convert profile to map for API update
        final updateData = {
          'location': updatedProfile.location,
          'dateOfBirth': updatedProfile.dob.toIso8601String(),
          'school': {
            'country': updatedProfile.school.country,
            'name': updatedProfile.school.name,
          },
          'occupation': updatedProfile.occupation,
          'interests': updatedProfile.interests,
          'languages': updatedProfile.languages,
          'image': updatedProfile.image,
        };

        final result =
            await _profileApiService.updateProfile(profileId, updateData);
        result.fold(
          (error) => emit(ProfileFailure(error)),
          (data) {
            profile = updatedProfile;
            emit(ProfileLoaded(profile: profile));
          },
        );
      } catch (e) {
        emit(ProfileFailure(e.toString()));
      }
    });
  }
}

List<String> _updateInterests(
    List<String> existingInterests, String newInterest) {
  List<String> updatedInterests =
      List.from(existingInterests); // Copy the existing list

  if (updatedInterests.contains(newInterest)) {
    updatedInterests.remove(newInterest); // Remove if it already exists
  } else {
    updatedInterests.add(newInterest); // Add if it's new
  }

  return updatedInterests;
}

List<String> _updateLanguages(
    List<String> existingLanguages, String newLanguage) {
  List<String> updatedLanguages =
      List.from(existingLanguages); // Copy the existing list

  if (updatedLanguages.contains(newLanguage)) {
    updatedLanguages.remove(newLanguage);
    // Remove if it already exists
  } else {
    updatedLanguages.add(newLanguage);
  }
  print(updatedLanguages); // Add if it's new

  return updatedLanguages;
}
