import 'package:dartz/dartz.dart';
import '../../profile_exports.dart';

class UpdateProfileImageUseCase {
  final ProfileRepository _repository = sl<ProfileRepository>();

  UpdateProfileImageUseCase();

  Future<Either<String, Map<String, dynamic>>> call(dynamic imageFile) async {
    return await _repository.updateProfileImage(imageFile);
  }
}
