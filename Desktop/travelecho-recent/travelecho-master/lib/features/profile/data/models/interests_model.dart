import 'package:equatable/equatable.dart';

class InterestModel extends Equatable {
  final String title;
  final String category;
  final String subCategory;

  const InterestModel(
      {required this.title, required this.category, required this.subCategory});

  factory InterestModel.fromJson(Map<String, dynamic> json) {
    return InterestModel(
        title: json['title'] as String,
        category: json['category'] as String,
        subCategory: json['subcategory'] as String);
  }

  @override
  List<Object> get props => [title, category, subCategory];
}

class InterestsModel extends Equatable {
  final List<InterestModel> interests;

  const InterestsModel({required this.interests});

  factory InterestsModel.fromJson(List<dynamic> json) {
    return InterestsModel(
        interests:
            json.map((interest) => InterestModel.fromJson(interest)).toList());
  }

  factory InterestsModel.sort(
      InterestsModel allInterests, String interestHint) {
    return InterestsModel(
        interests: allInterests.interests
            .where((interestModel) => interestModel.title
                .toLowerCase()
                .contains(interestHint.toLowerCase()))
            .toList());
  }
  List<InterestModel> toList() {
    return interests;
  }
  
  @override
  List<Object?> get props => [interests];
}
