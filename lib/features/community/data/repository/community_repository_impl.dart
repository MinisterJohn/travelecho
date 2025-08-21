import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../community_exports.dart';

class CommunityRepositoryImpl implements CommunityRepository {
  final CommunityRemoteDataSource remoteDataSource =
      sl<CommunityRemoteDataSource>();

  CommunityRepositoryImpl();

  @override
  Future<Either<String, PostModel>> createPost(FormData formData) {
    return remoteDataSource.createPost(formData);
  }

  @override
  Future<Either<String, List<PostModel>>> getPosts({
    int skip = 0,
    int limit = 10,
  }) {
    return remoteDataSource.getPosts(skip: skip, limit: limit);
  }

  @override
  Future<Either<String, bool>> toggleLike(String postId) {
    return remoteDataSource.toggleLike(postId);
  }

  @override
  Future<Either<String, CommentModel>> createComment({
    required String postId,
    required String content,
    String? parentComment,
  }) {
    return remoteDataSource.createComment(
      postId: postId,
      content: content,
      parentComment: parentComment,
    );
  }

  @override
  Future<Either<String, List<CommentModel>>> getComments({
    required String postId,
    int skip = 0,
    int limit = 10,
    String? sort,
    String? select,
    String? populate,
  }) {
    return remoteDataSource.getComments(
      postId: postId,
      skip: skip,
      limit: limit,
      sort: sort,
      select: select,
      populate: populate,
    );
  }

  // ---------- Comment Methods ----------
  @override
  Future<Either<String, bool>> updateComment({
    required String postId,
    required String commentId,
    required String content,
  }) {
    return remoteDataSource.updateComment(
      postId: postId,
      commentId: commentId,
      content: content,
    );
  }

  @override
  Future<Either<String, bool>> deleteComment({
    required String postId,
    required String commentId,
  }) {
    return remoteDataSource.deleteComment(
      postId: postId,
      commentId: commentId,
    );
  }

  @override
  Future<Either<String, List<CommentModel>>> getReplies({
    required String postId,
    required String commentId,
    int skip = 0,
    int limit = 10,
  }) {
    return remoteDataSource.getReplies(
      postId: postId,
      commentId: commentId,
      skip: skip,
      limit: limit,
    );
  }

  @override
  Future<Either<String, CommentModel>> createReply({
    required String postId,
    required String commentId,
    required String content,
  }) {
    return remoteDataSource.createReply(
      postId: postId,
      commentId: commentId,
      content: content,
    );
  }

  @override
  Future<Either<String, bool>> toggleCommentLike({
    required String postId,
    required String commentId,
  }) {
    return remoteDataSource.toggleCommentLike(
      postId: postId,
      commentId: commentId,
    );
  }

  // ---------- Post Methods (New) ----------
  @override
  Future<Either<String, PostModel>> getPostById(String postId) {
    return remoteDataSource.getPostById(postId);
  }

  @override
  Future<Either<String, bool>> updatePost({
    required String postId,
    required Map<String, dynamic> updatedFields,
  }) {
    return remoteDataSource.updatePost(
      postId: postId,
      updatedFields: updatedFields,
    );
  }

  @override
  Future<Either<String, bool>> deletePost(String postId) {
    return remoteDataSource.deletePost(postId);
  }
    // ---------- Add Media to Post ----------
  @override
  Future<Either<String, Map<String, int>>> addPostMedia({
    required String postId,
    required List<File> files,
  }) {
    return remoteDataSource.addPostMedia(postId: postId, files: files);
  }
}
