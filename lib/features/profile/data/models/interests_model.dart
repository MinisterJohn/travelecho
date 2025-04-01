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
  final List<String> interests;

  const InterestsModel({required this.interests});

  factory InterestsModel.fromJson(List<dynamic> json) {
    return InterestsModel(
      interests: json.map((interest) => interest.toString()).toList(),
    );
  }

  factory InterestsModel.sort(InterestsModel allInterests, String interestHint) {
    return InterestsModel(
      interests: allInterests.interests
          .where((interest) => interest.toLowerCase().contains(interestHint.toLowerCase()))
          .toList(),
    );
  }

  List<String> toList() {
    return interests;
  }

  @override
  List<Object?> get props => [interests];
}
