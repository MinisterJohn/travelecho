import 'package:equatable/equatable.dart';

class TravelerDetails extends Equatable {
  final String id;
  final String dateOfBirth;
  final TravelerName name;
  final TravelerContact contact;
  final List<TravelerDocument> documents;

  TravelerDetails({
    required this.id,
    required this.dateOfBirth,
    required this.name,
    required this.contact,
    required this.documents,
  });

  factory TravelerDetails.fromJson(Map<String, dynamic> json) {
    return TravelerDetails(
      id: json['id'] as String,
      dateOfBirth: json['dateOfBirth'] as String,
      name: TravelerName.fromJson(json['name'] as Map<String, dynamic>),
      contact:
          TravelerContact.fromJson(json['contact'] as Map<String, dynamic>),
      documents: (json['documents'] as List<dynamic>)
          .map((e) => TravelerDocument.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dateOfBirth': dateOfBirth,
      'name': name.toJson(),
      'contact': contact.toJson(),
      'documents': documents.map((e) => e.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [id, dateOfBirth, name, contact, documents];
}

class TravelerName extends Equatable {
  final String firstName;
  final String lastName;

  TravelerName({
    required this.firstName,
    required this.lastName,
  });

  factory TravelerName.fromJson(Map<String, dynamic> json) {
    return TravelerName(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
    };
  }

  @override
  List<Object?> get props => [firstName, lastName];
}

class TravelerContact extends Equatable {
  final List<TravelerPhone> phones;

  TravelerContact({
    required this.phones,
  });

  factory TravelerContact.fromJson(Map<String, dynamic> json) {
    return TravelerContact(
      phones: (json['phones'] as List<dynamic>)
          .map((e) => TravelerPhone.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'phones': phones.map((e) => e.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [phones];
}

class TravelerPhone extends Equatable {
  final String countryCallingCode;
  final String number;

  TravelerPhone({
    required this.countryCallingCode,
    required this.number,
  });

  factory TravelerPhone.fromJson(Map<String, dynamic> json) {
    return TravelerPhone(
      countryCallingCode: json['countryCallingCode'] as String,
      number: json['number'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'countryCallingCode': countryCallingCode,
      'number': number,
    };
  }

  @override
  List<Object?> get props => [countryCallingCode, number];
}

class TravelerDocument extends Equatable {
  final String documentType;
  final String number;
  final String expiryDate;
  final String issuanceCountry;
  final String nationality;
  final bool holder;

  TravelerDocument({
    required this.documentType,
    required this.number,
    required this.expiryDate,
    required this.issuanceCountry,
    required this.nationality,
    required this.holder,
  });

  factory TravelerDocument.fromJson(Map<String, dynamic> json) {
    return TravelerDocument(
      documentType: json['documentType'] as String,
      number: json['number'] as String,
      expiryDate: json['expiryDate'] as String,
      issuanceCountry: json['issuanceCountry'] as String,
      nationality: json['nationality'] as String,
      holder: json['holder'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'documentType': documentType,
      'number': number,
      'expiryDate': expiryDate,
      'issuanceCountry': issuanceCountry,
      'nationality': nationality,
      'holder': holder,
    };
  }

  @override
  List<Object?> get props => [
        documentType,
        number,
        expiryDate,
        issuanceCountry,
        nationality,
        holder,
      ];
}
