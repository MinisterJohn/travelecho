import 'package:equatable/equatable.dart';

class TravelDocumentModel extends Equatable {
  final String user;
  final String id;
  final String passportNumber;
  final String passportType;
  final String fullName;
  final String nationality;
  final DateTime issueDate;
  final DateTime expiryDate;
  final String? placeOfIssue;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<String> imageUrls;

  const TravelDocumentModel({
    required this.user,
    required this.id,
    required this.passportNumber,
    required this.passportType,
    required this.fullName,
    required this.nationality,
    required this.issueDate,
    required this.expiryDate,
    this.placeOfIssue,
    required this.createdAt,
    required this.updatedAt,
    required this.imageUrls,
  });

  factory TravelDocumentModel.fromJson(Map<String, dynamic> json) {
    return TravelDocumentModel(
      user: json['user'] as String,
      id: json['_id'] as String,
      passportNumber: json['passportNumber'] as String,
      passportType: json['passportType'] as String,
      fullName: json['fullName'] as String,
      nationality: json['nationality'] as String,
      issueDate: DateTime.parse(json['issueDate']),
      expiryDate: DateTime.parse(json['expiryDate']),
      placeOfIssue: json['placeOfIssue'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      imageUrls:
          (json['images'] as List<dynamic>?)
              ?.map((e) => e['url'].toString())
              .toList() ??
          <String>[],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user,
      'id': id,
      'passportNumber': passportNumber,
      'passportType': passportType,
      'fullName': fullName,
      'nationality': nationality,
      'issueDate': issueDate.toIso8601String(),
      'expiryDate': expiryDate.toIso8601String(),
      'placeOfIssue': placeOfIssue,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'imageUrls': imageUrls,
    };
  }

  TravelDocumentModel copyWith({
    String? user,
    String? id,
    String? passportNumber,
    String? passportType,
    String? fullName,
    String? nationality,
    DateTime? issueDate,
    DateTime? expiryDate,
    String? placeOfIssue,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<String>? imageUrls,
  }) {
    return TravelDocumentModel(
      user: user ?? this.user,
      id: id ?? this.id,
      passportNumber: passportNumber ?? this.passportNumber,
      passportType: passportType ?? this.passportType,
      fullName: fullName ?? this.fullName,
      nationality: nationality ?? this.nationality,
      issueDate: issueDate ?? this.issueDate,
      expiryDate: expiryDate ?? this.expiryDate,
      placeOfIssue: placeOfIssue ?? this.placeOfIssue,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      imageUrls: imageUrls ?? this.imageUrls,
    );
  }

  @override
  List<Object?> get props => [
    user,
    id,
    passportNumber,
    passportType,
    fullName,
    nationality,
    issueDate,
    expiryDate,
    placeOfIssue,
    createdAt,
    updatedAt,
    imageUrls,
  ];
}
