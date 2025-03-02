import 'package:equatable/equatable.dart';

class OccupationsModel extends Equatable {
  final List<dynamic> occupations;

  const OccupationsModel({required this.occupations});

  factory OccupationsModel.fromJson(Map<String, dynamic> json) {
    return OccupationsModel(occupations: json["occupations"] ?? []);
  }
  factory OccupationsModel.sort(
      OccupationsModel allOccupations, String occupationHint) {
    return OccupationsModel(
        occupations: allOccupations.occupations
            .where((occupation) =>
                occupation.toLowerCase().contains(occupationHint.toLowerCase()))
            .toList());
  }

  List<dynamic> toList() {
    return occupations;
  }
  
  @override
  List<Object?> get props => [occupations];
}
