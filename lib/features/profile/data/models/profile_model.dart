// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import '../../profile_exports.dart';

class Profile extends Equatable {
  final String location;
  final String image;
  final DateTime dob;
  final SchoolModel school;
  final String occupation;
  final List<String> interests;
  final List<String> languages;

  const Profile(
      {required this.location,
      required this.image,
      required this.dob,
      required this.school,
      required this.occupation,
      required this.interests,
      required this.languages});

  @override
  List<Object?> get props => [location, image, dob, school, occupation, interests, languages];

  Profile copyWith({
    required String location,
    required String image,
    required DateTime dob,
    required SchoolModel school,
    required String occupation,
    required List<String> interests,
    required List<String> languages,
  }) {
    return Profile(
      location: location,
      image: image,
      dob: dob,
      school: school,
      occupation: occupation,
      interests: interests,
      languages: languages
    );
  }
}
