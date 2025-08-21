import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../profile_exports.dart';

class ProfileRepositoryImpl implements ProfileRepository {
   final ProfileApiService _apiService = sl<ProfileApiService>();
  
  ProfileRepositoryImpl();

  @override
  Future<Either<String, Profile>> getUserProfile() {
    try {
      return _apiService.getUserProfile().then((result) {
        return result.fold(
          (failure) => Left(failure),
          (profile) => Right(profile),
        );
      });
    } catch (e) {
      return Future.value(Left(e.toString()));
    }
  }

 /// Update the profile image using FormData
  @override
  Future<Either<String, Map<String, dynamic>>> updateProfileImage(
      FormData formData) {
    try {
      return _apiService.updateProfileImage(formData);
    } catch (e) {
      return Future.value(Left(e.toString()));
    }
  }

  @override
  Future<Either<String, Profile>> updateUserProfile(Map<String, dynamic> data) {
    try {
      return _apiService.updateUserProfile(data);
    } catch (e) {
      return Future.value(Left(e.toString()));
    }
  }
}
