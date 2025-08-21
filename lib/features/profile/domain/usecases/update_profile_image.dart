import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../profile_exports.dart';

class UpdateProfileImageUseCase {
  final ProfileRepository _repository = sl<ProfileRepository>();

  UpdateProfileImageUseCase();

  /// Accepts FormData instead of dynamic
  Future<Either<String, Map<String, dynamic>>> call(FormData formData) async {
    return await _repository.updateProfileImage(formData);
  }
}
