import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelecho/features/auth/data/models/signup_req_params.dart';
import 'package:travelecho/features/auth/data/sources/auth_api_service.dart';
import 'package:travelecho/features/auth/domain/repository/auth_repository.dart';
import 'package:travelecho/service_locator.dart';
import 'package:travelecho/features/auth/data/models/signin_req_params.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<Either> signin(SigninReqParams params) async {
    var data = await sl<AuthApiService>().signin(params);

    return data.fold((error) {
      return Left(error);
    }, (data) async {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString('token', data['token']);
      return Right(data);
    });
  }

  @override
  Future<Either> signup(SignupReqParams params) async {
    var data = await sl<AuthApiService>().signup(params);

    return data.fold((error) {
      return Left(error);
    }, (data) async {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString('token', data['token']);
      sharedPreferences.setBool('is_not_new_user', false);
      return Right(data);
    });
  }

  @override
  Future<bool> isLoggedIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('token');
    if (token == null) return false;
    return true;
  }

  // ignore: non_constant_identifier_names
  @override
  Future<bool> isNotNewUser() async {
    late SharedPreferences sharedPreferences;

    sharedPreferences = await SharedPreferences.getInstance();
    bool? isNotNewUser = sharedPreferences.getBool('is_not_new_user');
    if (isNotNewUser == null) return true;
    return false;
  }

  // @override
  // Future<Either> resetPassword(String email) async {
  //   await apiService.resetPassword(email);
  // }
}
