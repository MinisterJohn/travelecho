// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:travelecho/features/profile/data/models/interests_model.dart';
import 'package:travelecho/features/profile/data/models/languages_model.dart';
import 'package:travelecho/features/profile/data/models/schools_list_model.dart';

class Profile extends Equatable {
  final String location;
  final DateTime dob;
  final SchoolModel school;
  final String occupation;
  final List<InterestModel> interests;
  final List<LanguageModel> languages;

  const Profile(
      {required this.location,
      required this.dob,
      required this.school,
      required this.occupation,
      required this.interests,
      required this.languages});

  @override
  List<Object?> get props => [location, dob, school, occupation, interests, languages];

  Profile copyWith({
    required String location,
    required DateTime dob,
    required SchoolModel school,
    required String occupation,
    required List<InterestModel> interests,
    required List<LanguageModel> languages,
  }) {
    return Profile(
      location: location,
      dob: dob,
      school: school,
      occupation: occupation,
      interests: interests,
      languages: languages
    );
  }
}
