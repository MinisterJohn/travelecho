import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../profile_exports.dart';

abstract class ProfileRepository {
  Future<Either<String, Profile>> getUserProfile();
 Future<Either<String, Map<String, dynamic>>> updateProfileImage(
      FormData formData);
  Future<Either<String, Profile>> updateUserProfile(Map<String, dynamic> data);
}
