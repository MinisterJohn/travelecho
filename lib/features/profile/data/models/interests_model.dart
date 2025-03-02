import 'package:equatable/equatable.dart';

class InterestModel extends Equatable {
  final String interest;

  const InterestModel({required this.interest});

  factory InterestModel.fromJson(Map<String, dynamic> json) {
    return InterestModel(
      interest: json['title'] as String,
    );
  }

  @override
  List<Object> get props => [interest];
}

class InterestsModel extends Equatable {
  final List<InterestModel> interests;

  const InterestsModel({required this.interests});

  factory InterestsModel.fromJson(List<dynamic> json) {
    return InterestsModel(
      interests: json.map((interest) => InterestModel.fromJson(interest)).toList(),
    );
  }

  factory InterestsModel.sort(InterestsModel allInterests, String interestHint) {
    return InterestsModel(
      interests: allInterests.interests
          .where((interestModel) => interestModel.interest
              .toLowerCase()
              .contains(interestHint.toLowerCase()))
          .toList(),
    );
  }

  List<InterestModel> toList() {
    return interests;
  }

  @override
  List<Object?> get props => [interests];
}
