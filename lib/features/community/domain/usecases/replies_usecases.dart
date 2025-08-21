import 'package:dartz/dartz.dart';
import '../../community_exports.dart';

// ----------------- REPLIES -----------------
class GetRepliesUseCase {
  final CommunityRepository repository = sl<CommunityRepository>();
  GetRepliesUseCase();

  Future<Either<String, List<CommentModel>>> call({
    required String postId,
    required String commentId,
    int skip = 0,
    int limit = 10,
  }) {
    return repository.getReplies(
      postId: postId,
      commentId: commentId,
      skip: skip,
      limit: limit,
    );
  }
}

class CreateReplyUseCase {
  final CommunityRepository repository = sl<CommunityRepository>();
  CreateReplyUseCase();

  Future<Either<String, CommentModel>> call({
    required String postId,
    required String commentId,
    required String content,
  }) {
    return repository.createReply(
      postId: postId,
      commentId: commentId,
      content: content,
    );
  }
}

class ToggleCommentLikeUseCase {
  final CommunityRepository repository = sl<CommunityRepository>();
  ToggleCommentLikeUseCase();

  Future<Either<String, bool>> call({
    required String postId,
    required String commentId,
  }) {
    return repository.toggleCommentLike(
      postId: postId,
      commentId: commentId,
    );
  }
}