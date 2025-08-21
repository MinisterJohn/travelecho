import 'package:dartz/dartz.dart';
import '../../community_exports.dart';

/// UseCase for toggling like/unlike a post
class ToggleLikeUseCase {
  final CommunityRepository repository = sl<CommunityRepository>();

  ToggleLikeUseCase();

  Future<Either<String, bool>> call(String postId) {
    return repository.toggleLike(postId);
  }
}
