import 'package:equatable/equatable.dart';

class InterestModel extends Equatable {
  final String title;
  final String category;
  final String subCategory;

  const InterestModel({
    required this.title,
    required this.category,
    required this.subCategory,
  });

  factory InterestModel.fromJson(Map<String, dynamic> json) {
    return InterestModel(
      title: json['title']?.toString() ?? '',
      category: json['category']?.toString() ?? '',
      subCategory: json['subCategory']?.toString() ?? '',
    );
  }

  @override
  List<Object> get props => [title, category, subCategory];
}

class InterestsModel extends Equatable {
  final List<InterestModel> interests;

  const InterestsModel({required this.interests});

  factory InterestsModel.fromJson(List<dynamic> json) {
    return InterestsModel(
      interests: json
          .map((interest) =>
              InterestModel.fromJson(interest as Map<String, dynamic>))
          .toList(),
    );
  }

  factory InterestsModel.sort(
      InterestsModel allInterests, String interestHint) {
    return InterestsModel(
      interests: allInterests.interests
          .where((interest) =>
              interest.title.toLowerCase().contains(interestHint.toLowerCase()))
          .toList(),
    );
  }

  List<String> toList() {
    return interests.map((interest) => interest.title).toList();
  }

  @override
  List<Object?> get props => [interests];
}
