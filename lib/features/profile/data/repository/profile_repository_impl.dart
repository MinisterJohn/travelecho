import 'package:dartz/dartz.dart';
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

  @override
  Future<Either<String, Map<String, dynamic>>> updateProfileImage(
      dynamic imageFile) {
    try {
      return _apiService.updateProfileImage(imageFile);
    } catch (e) {
      return Future.value(Left(e.toString()));
    }
  }
}
