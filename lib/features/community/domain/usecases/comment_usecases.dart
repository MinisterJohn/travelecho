import 'package:dartz/dartz.dart';
import '../../community_exports.dart';

// ----------------- COMMENTS -----------------
class CreateCommentUseCase {
  final CommunityRepository repository = sl<CommunityRepository>();
  CreateCommentUseCase();

  Future<Either<String, CommentModel>> call({
    required String postId,
    required String content,
    String? parentComment,
  }) {
    return repository.createComment(
      postId: postId,
      content: content,
      parentComment: parentComment,
    );
  }
}

class GetCommentsUseCase {
  final CommunityRepository repository = sl<CommunityRepository>();
  GetCommentsUseCase();

  Future<Either<String, List<CommentModel>>> call({
    required String postId,
    int skip = 0,
    int limit = 10,
    String? sort,
    String? select,
    String? populate,
  }) {
    return repository.getComments(
      postId: postId,
      skip: skip,
      limit: limit,
      sort: sort,
      select: select,
      populate: populate,
    );
  }
}

class UpdateCommentUseCase {
  final CommunityRepository repository = sl<CommunityRepository>();
  UpdateCommentUseCase();

  Future<Either<String, bool>> call({
    required String postId,
    required String commentId,
    required String content,
  }) {
    return repository.updateComment(
      postId: postId,
      commentId: commentId,
      content: content,
    );
  }
}

class DeleteCommentUseCase {
  final CommunityRepository repository = sl<CommunityRepository>();
  DeleteCommentUseCase();

  Future<Either<String, bool>> call({
    required String postId,
    required String commentId,
  }) {
    return repository.deleteComment(
      postId: postId,
      commentId: commentId,
    );
  }
}