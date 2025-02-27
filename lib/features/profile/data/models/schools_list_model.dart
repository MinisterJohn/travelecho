import 'package:equatable/equatable.dart';

class SchoolModel extends Equatable {
  final String name;
  final String country;

  const SchoolModel({required this.name, required this.country});

  factory SchoolModel.fromJson(Map<String, dynamic> json) {
    return SchoolModel(
      name: json['name'] as String,
      country: json['country'] as String,
    );
  }
  
  @override
  List<Object?> get props => [name, country];
}

class SchoolListModel extends Equatable {
  final List<SchoolModel> schools;

  const SchoolListModel({required this.schools});

  factory SchoolListModel.fromJson(List<dynamic> json) {
    return SchoolListModel(
      schools: json.map((school) => SchoolModel.fromJson(school)).toList(),
    );
  }

  List<SchoolModel> toList() {
    return schools;
  }
  
  @override
  List<Object?> get props =>[schools];
}
