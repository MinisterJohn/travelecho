import 'package:equatable/equatable.dart';

class Country extends Equatable {
  final String name;
  final String code;
  final String phoneCode;
  final String flag;

  const Country({
    required this.name,
    required this.code,
    required this.phoneCode,
    required this.flag,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name'] as String,
      code: json['code'] as String,
      phoneCode: json['phoneCode'] as String,
      flag: json['flag'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'code': code,
      'phoneCode': phoneCode,
      'flag': flag,
    };
  }

  @override
  List<Object?> get props => [name, code, phoneCode, flag];
}
