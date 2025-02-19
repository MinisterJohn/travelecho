class OccupationsModel {
  final List<dynamic> occupations;

  OccupationsModel({required this.occupations});

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
}
