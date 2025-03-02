class SigninReqParams {
  final String email;
  final String password;
  final String fullname;

  SigninReqParams({
    required this.email,
    required this.password,
    required this.fullname,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
      'fullname': fullname,
    };
  }



  @override
  String toString() => 'SignupReqParams(email: $email, password: $password, fullname: $fullname)';

}
