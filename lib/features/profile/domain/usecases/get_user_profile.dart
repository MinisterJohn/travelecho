import 'package:dartz/dartz.dart';
import '../../profile_exports.dart';

class GetUserProfileUseCase {
  final ProfileRepository _repository = sl<ProfileRepository>();

  GetUserProfileUseCase();

  Future<Either<String, Profile>> call() {
    return _repository.getUserProfile();
  }
}
