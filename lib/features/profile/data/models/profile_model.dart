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
  print('Parsing Profile from JSON: $json');

  try {
    // Safely extract the image URL
    String imageUrl = '';
    if (json['image'] != null && json['image'] is Map<String, dynamic>) {
      final imageData = json['image'] as Map<String, dynamic>;
      imageUrl = imageData['url']?.toString() ?? '';
    }

    return Profile(
      id: json['_id'] != null ? json['_id'].toString() : '',
      userId: json['user'] != null ? json['user'].toString() : '',
      interests: (json['interests'] is List)
          ? List<String>.from(json['interests'].map((e) => e.toString()))
          : [],
      languages: (json['languages'] is List)
          ? List<String>.from(json['languages'].map((e) => e.toString()))
          : [],
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'].toString()) ?? DateTime.now()
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'].toString()) ?? DateTime.now()
          : DateTime.now(),
      dateOfBirth: json['dateOfBirth'] != null
          ? DateTime.tryParse(json['dateOfBirth'].toString())
          : null,
      image: imageUrl,
      location: json['location'] != null ? json['location'].toString() : '',
      occupation:
          json['occupation'] != null ? json['occupation'].toString() : '',
      school: json['school'] != null
          ? SchoolModel.fromJson(json['school'])
          : SchoolModel.fromJson({}),
    );
  } catch (e, stackTrace) {
    print('Error parsing profile: $e\n$stackTrace');
    // Return a default profile if parsing fails
    return Profile(
      id: '',
      userId: '',
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
