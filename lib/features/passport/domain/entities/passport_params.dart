class TravelDocumentParams {
  // final String user;
  final String passportNumber;
  final String passportType;
  final String fullName;
  final String nationality;
  final DateTime issueDate;
  final DateTime expiryDate;
  final String? placeOfIssue;

  TravelDocumentParams({
    // required this.user,
    required this.passportNumber,
    required this.passportType,
    required this.fullName,
    required this.nationality,
    required this.issueDate,
    required this.expiryDate,
    this.placeOfIssue,
  });

  Map<String, dynamic> toJson() {
    return {
      // 'user': user,
      'passportNumber': passportNumber,
      'passportType': passportType,
      'fullName': fullName,
      'nationality': nationality,
      'issueDate': issueDate.toIso8601String(),
      'expiryDate': expiryDate.toIso8601String(),
      if (placeOfIssue != null) 'placeOfIssue': placeOfIssue,
    };
  }

  factory TravelDocumentParams.fromJson(Map<String, dynamic> json) {
    return TravelDocumentParams(
      // user: json['user'] as String,
      passportNumber: json['passportNumber'] as String,
      passportType: json['passportType'] as String,
      fullName: json['fullName'] as String,
      nationality: json['nationality'] as String,
      issueDate: DateTime.parse(json['issueDate'] as String),
      expiryDate: DateTime.parse(json['expiryDate'] as String),
      placeOfIssue: json['placeOfIssue'] as String?,
    );
  }
}
