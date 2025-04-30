class SignupReqParams {
  final String email;
  final String password;
  final String name;

  SignupReqParams({
    required this.email,
    required this.password,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
      'confirmPassword': password,
      'name': name,
    };
  }

  @override
  String toString() =>
      'SignupReqParams(email: $email, password: $password, fullname: $name)';
}
