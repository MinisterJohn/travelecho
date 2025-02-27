import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:travelecho/core/constants/api_url.dart';
import 'package:travelecho/features/auth/data/models/signin_req_params.dart';
import 'package:travelecho/features/auth/data/models/signup_req_params.dart';

abstract class AuthApiService {
  Future<Either> signin(SigninReqParams params);
  // Future<Either> login(String email, String password);
  Future<Either> signup(SignupReqParams params);
  // Future<Either> resetPassword(String email);
}

class AuthApiServiceImpl implements AuthApiService {

  final Dio dio = Dio(); // Or your HTTP client



  @override
  Future<Either> signin(SigninReqParams params) async {
    try {
      final response = await dio.post(ApiUrl.signinURL, data: params.toMap());
      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response!.data["message"]);
    }
  }
  
  @override
  Future<Either> signup(SignupReqParams params) async {
    try {
      final response = await dio.post(ApiUrl.signupURL, data: params.toMap());
      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response!.data["message"]);
    }
  }

  // @override
  // Future<Either> resetPassword(String email) async {
  //   await sl<DioClient>().post('/auth/reset-password', data: {'email': email});
  // }
}
