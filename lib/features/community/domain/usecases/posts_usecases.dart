import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../community_exports.dart';

// ----------------- POSTS -----------------
class CreatePostUseCase {
  final CommunityRepository repository = sl<CommunityRepository>();
  CreatePostUseCase();

  Future<Either<String, PostModel>> call(FormData formData) {
    return repository.createPost(formData);
  }
}

class AddPostMediaUseCase {
  final CommunityRepository repository = sl<CommunityRepository>();

  AddPostMediaUseCase();

  Future<Either<String, Map<String, int>>> call({
    required String postId,
    required List<File> files,
  }) {
    return repository.addPostMedia(postId: postId, files: files);
  }
}

class GetPostsUseCase {
  final CommunityRepository repository = sl<CommunityRepository>();
  GetPostsUseCase();

  Future<Either<String, List<PostModel>>> call({int skip = 0, int limit = 10}) {
    return repository.getPosts(skip: skip, limit: limit);
  }
}

/// ---------- Get Post By ID ----------
class GetPostByIdUseCase {
  final CommunityRepository repository = sl<CommunityRepository>();
  GetPostByIdUseCase();

  Future<Either<String, PostModel>> call(String postId) {
    return repository.getPostById(postId);
  }
}

/// ---------- Update Post ----------
class UpdatePostUseCase {
  final CommunityRepository repository = sl<CommunityRepository>();
  UpdatePostUseCase();

  Future<Either<String, bool>> call({
    required String postId,
    required Map<String, dynamic> updatedFields,
  }) {
    return repository.updatePost(postId: postId, updatedFields: updatedFields);
  }
}

/// ---------- Delete Post ----------
class DeletePostUseCase {
  final CommunityRepository repository = sl<CommunityRepository>();
  DeletePostUseCase();

  Future<Either<String, bool>> call(String postId) {
    return repository.deletePost(postId);
  }
}

class TogglePostLikeUseCase {
  final CommunityRepository repository = sl<CommunityRepository>();
  TogglePostLikeUseCase();

  Future<Either<String, bool>> call(String postId) {
    return repository.toggleLike(postId);
  }
}
