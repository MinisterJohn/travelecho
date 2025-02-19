class SchoolModel {
  final String name;
  final String country;

  SchoolModel({required this.name, required this.country});

  factory SchoolModel.fromJson(Map<String, dynamic> json) {
    return SchoolModel(
      name: json['name'] as String,
      country: json['country'] as String,
    );
  }
}

class SchoolListModel {
  final List<SchoolModel> schools;

  SchoolListModel({required this.schools});

  factory SchoolListModel.fromJson(List<dynamic> json) {
    return SchoolListModel(
      schools: json.map((school) => SchoolModel.fromJson(school)).toList(),
    );
  }

  List<SchoolModel> toList() {
    return schools;
  }
}
