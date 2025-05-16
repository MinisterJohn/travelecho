// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../profile_exports.dart';

final SharedPreferences _prefs = sl<SharedPreferences>();

// class ProfileUser extends Equatable {
//   final String name;
//   final String email;
//   final bool verified;
//   final String plan;
//   final dynamic subscription;

//   ProfileUser({
//     this.name = _prefs.getString('name') ?? '',
//     this.email = _prefs.getString('email') ?? '',
//     required this.verified,
//     required this.plan,
//     this.subscription,
//   });

//   factory ProfileUser.fromJson(Map<String, dynamic> json) {
//     return ProfileUser(
//       name: json['name'] ?? '',
//       email: json['email'] ?? '',
//       verified: json['verified'] ?? false,
//       plan: json['plan'] ?? 'FREE',
//       subscription: json['subscription'],
//     );
//   }

//   @override
//   List<Object?> get props => [name, email, verified, plan, subscription];
// }

class Profile extends Equatable {
  final String id;
  final String userId;
  final List<String> interests;
  final List<String> languages;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? dateOfBirth;
  // final ProfileUser? user;
  final String image;
  final String location;
  final String occupation;
  final SchoolModel school;

  const Profile({
    required this.id,
    required this.userId,
    required this.interests,
    required this.languages,
    required this.createdAt,
    required this.updatedAt,
    this.dateOfBirth,
    // this.user,
    this.image = '',
    this.location = '',
    this.occupation = '',
    required this.school,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    try {
      return Profile(
        id: json['_id']?.toString() ?? '',
        userId: json['user']?.toString() ?? '',
        interests: List<String>.from(json['interests'] ?? []),
        languages: List<String>.from(json['languages'] ?? []),
        createdAt: DateTime.parse(
            json['createdAt']?.toString() ?? DateTime.now().toIso8601String()),
        updatedAt: DateTime.parse(
            json['updatedAt']?.toString() ?? DateTime.now().toIso8601String()),
        dateOfBirth: json['dateOfBirth'] != null
            ? DateTime.parse(json['dateOfBirth'].toString())
            : null,
        // user: json['user'] != null ? ProfileUser.fromJson(json['user']) : null,
        image: () {
          final imageData = json['image'];
          print('Image data type: ${imageData.runtimeType}');
          print('Image data: $imageData');
          if (imageData != null && imageData is Map<String, dynamic>) {
            final url = imageData['url'];
            print('URL from image: $url');
            return url?.toString() ?? '';
          }
          return '';
        }(),
        location: json['location']?.toString() ?? '',
        occupation: json['occupation']?.toString() ?? '',
        school: SchoolModel.fromJson(json['school'] ?? {}),
      );
    } catch (e) {
      print('Error parsing profile: $e');
      // Return a default profile if parsing fails
      return Profile(
        id: '',
        userId: '',
        image: '',
        interests: const [],
        languages: const [],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        school: SchoolModel.fromJson(const {}),
      );
    }
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'user': userId,
      'interests': interests,
      'languages': languages,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'image': image,
      'location': location,
      'occupation': occupation,
      'school': school.toJson(),
    };
  }

  Profile copyWith({
    required String location,
    required String image,
    required DateTime dateOfBirth,
    required SchoolModel school,
    required String occupation,
    required List<String> interests,
    required List<String> languages,
  }) {
    return Profile(
        id: id,
        userId: userId,
        createdAt: createdAt,
        updatedAt: updatedAt,
        dateOfBirth: dateOfBirth,
        image: image,
        location: location,
        school: school,
        occupation: occupation,
        interests: interests,
        languages: languages);
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        interests,
        languages,
        createdAt,
        updatedAt,
        dateOfBirth,
        // user,
        image,
        location,
        occupation,
        school
      ];
}
