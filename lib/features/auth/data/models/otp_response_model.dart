class OtpResponseModel {
  final String message;
  final bool success;
  final String? token;

  OtpResponseModel({
    required this.message,
    required this.success,
    this.token,
  });

  factory OtpResponseModel.fromJson(Map<String, dynamic> json) {
    return OtpResponseModel(
      message: json['message'] as String,
      success: json['success'] as bool,
      token: json['token'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'success': success,
      if (token != null) 'token': token,
    };
  }
}
