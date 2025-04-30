import 'package:equatable/equatable.dart';

class OtpRequestModel extends Equatable {
  final String email;

  const OtpRequestModel({
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
    };
  }

  @override
  List<Object?> get props => [email];
}

class OtpVerificationRequestModel extends Equatable {
  final String email;
  final String otp;

  const OtpVerificationRequestModel({
    required this.email,
    required this.otp,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'otp': otp,
    };
  }

  @override
  List<Object?> get props => [email, otp];
}

class OtpResponseModel extends Equatable {
  final bool success;
  final String message;

  const OtpResponseModel({
    required this.success,
    required this.message,
  });

  factory OtpResponseModel.fromJson(Map<String, dynamic> json) {
    return OtpResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
    );
  }

  @override
  List<Object?> get props => [success, message];
}
