import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import "../../community_exports.dart";

abstract class CommunityRepository {
  Future<Either<String, PostModel>> createPost(FormData formData);
  Future<Either<String, List<PostModel>>> getPosts({
    int skip = 0,
    int limit = 10,
  });
  Future<Either<String, bool>> toggleLike(String postId);
  Future<Either<String, CommentModel>> createComment({
    required String postId,
    required String content,
    String? parentComment,
  });
  Future<Either<String, List<CommentModel>>> getComments({
    required String postId,
    int skip = 0,
    int limit = 10,
    String? sort,
    String? select,
    String? populate,
  });
  Future<Either<String, bool>> updateComment({
    required String postId,
    required String commentId,
    required String content,
  });
  Future<Either<String, bool>> deleteComment({
    required String postId,
    required String commentId,
  });
  Future<Either<String, List<CommentModel>>> getReplies({
    required String postId,
    required String commentId,
    int skip = 0,
    int limit = 10,
  });
  Future<Either<String, CommentModel>> createReply({
    required String postId,
    required String commentId,
    required String content,
  });
  Future<Either<String, bool>> toggleCommentLike({
    required String postId,
    required String commentId,
  });
  Future<Either<String, PostModel>> getPostById(String postId);
  Future<Either<String, bool>> updatePost({
    required String postId,
    required Map<String, dynamic> updatedFields,
  });
  Future<Either<String, bool>> deletePost(String postId);
  Future<Either<String, Map<String, int>>> addPostMedia({
    required String postId,
    required List<File> files,
  });
}
