import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelecho/features/profile/data/models/interests_model.dart';
import 'package:travelecho/features/profile/data/models/languages_model.dart';
import 'package:travelecho/features/profile/data/models/profile_model.dart';
import 'package:travelecho/features/profile/data/models/schools_list_model.dart';

part "profile_state.dart";
part "profile_event.dart";

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  Profile profile = Profile(
    location: "",
    dob: DateTime.now(),
    school: const SchoolModel(country: "", name: ""),
    occupation: "",
    interests: const <InterestModel>[],
    languages: const <LanguageModel>[],
  );

  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileRequested>((event, emit) {
      emit(ProfileLoading(profile: profile));
      emit(ProfileLoaded(profile: profile));
    });

    on<ProfileUpdateRequested>((event, emit) {
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
            ? _updateInterests(
                profile.interests, event.updateValue as InterestModel)
            : profile.interests,
        languages: event.updateKey == ProfileUpdateKey.languages
            ? _updateLanguages(
                profile.languages, event.updateValue as LanguageModel)
            : profile.languages,
      );

      profile = updatedProfile; // Update the stored profile state
      print(updatedProfile);

      emit(ProfileLoaded(profile: profile));
    });
  }
}

List<InterestModel> _updateInterests(
    List<InterestModel> existingInterests, InterestModel newInterest) {
  List<InterestModel> updatedInterests =
      List.from(existingInterests); // Copy the existing list

  if (updatedInterests.contains(newInterest)) {
    updatedInterests.remove(newInterest); // Remove if it already exists
  } else {
    updatedInterests.add(newInterest); // Add if it's new
  }

  return updatedInterests;
}

List<LanguageModel> _updateLanguages(
    List<LanguageModel> existingLanguages, LanguageModel newLanguage) {
  List<LanguageModel> updatedLanguages =
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
