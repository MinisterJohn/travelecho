import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../community_exports.dart';

class CommunityRemoteDataSourceImpl implements CommunityRemoteDataSource {
  final DioClient dio = sl<DioClient>();
  final SharedPreferences _prefs = sl<SharedPreferences>();
  final Logger _logger = sl<Logger>();
  CommunityRemoteDataSourceImpl();

  Future<Options> _getOptions() async {
    final token = _prefs.getString('token');
    if (token == null || token.isEmpty) {
      throw Exception('Authorization token is missing. Please log in again.');
    }
    return Options(headers: {'Authorization': 'Bearer $token'});
  }

  String _handleError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timeout. Please check your internet connection.';
      case DioExceptionType.sendTimeout:
        return 'Send timeout. Please try again.';
      case DioExceptionType.receiveTimeout:
        return 'Receive timeout. Please try again.';
      case DioExceptionType.badResponse:
        return e.response?.data['message'] ?? 'An error occurred.';
      case DioExceptionType.cancel:
        return 'Request cancelled.';
      default:
        return 'An unexpected error occurred.';
    }
  }

  @override
  Future<Either<String, PostModel>> createPost(FormData formData) async {
    try {
      final response = await dio.post(
        ApiUrl.communityPostURL,
        data: formData,
        options: await _getOptions(),
      );
      _logger.i("Response data: ${response.data}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(PostModel.fromJson(response.data['post']));
      } else {
        _logger.e("Failed to create post: ${response.data}");
        return Left(response.statusMessage ?? "Failed to create post");
      }
    } on DioException catch (e) {
      return Left(_handleError(e));
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, Map<String, int>>> addPostMedia({
    required String postId,
    required List<File> files,
  }) async {
    if (files.isEmpty) {
      return Left("No files to upload.");
    }

    try {
      final formData = FormData();
      for (int i = 0; i < files.length; i++) {
        final file = files[i];
        formData.files.add(
          MapEntry(
            "file_${i + 1}",
            await MultipartFile.fromFile(
              file.path,
              filename: file.path.split('/').last,
            ),
          ),
        );
      }

      final response = await dio.put(
        "${ApiUrl.communityPostURL}/$postId/media/add",
        data: formData,
        options: await _getOptions(),
      );

      _logger.i("Add media response: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final uploaded = response.data['files']['uploaded'] as int? ?? 0;
        final errored = response.data['files']['errored'] as int? ?? 0;
        return Right({"uploaded": uploaded, "errored": errored});
      } else {
        return Left(response.statusMessage ?? "Failed to upload media");
      }
    } on DioException catch (e) {
      return Left(_handleError(e));
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<PostModel>>> getPosts({
    int skip = 0,
    int limit = 10,
  }) async {
    try {
      final response = await dio.get(
        ApiUrl.communityPostURL,
        queryParameters: {"skip": skip, "limit": limit},
        options: await _getOptions(),
      );
      _logger.i("Response data: ${response.data}");
      if (response.statusCode == 200) {
        final postsJson = response.data['posts'] as List<dynamic>;
        final posts = postsJson.map((e) => PostModel.fromJson(e)).toList();
        return Right(posts);
      } else {
        return Left(response.statusMessage ?? "Failed to fetch posts");
      }
    } on DioException catch (e) {
      return Left(_handleError(e));
    } catch (e) {
      return Left(e.toString());
    }
  }

   // ---------- Get Post By ID ----------
  @override
  Future<Either<String, PostModel>> getPostById(String postId) async {
    try {
      final response = await dio.get(
        "${ApiUrl.communityPostURL}/$postId",
        options: await _getOptions(),
      );

      _logger.i("Get post response: ${response.data}");

      if (response.statusCode == 200) {
        return Right(PostModel.fromJson(response.data['post']));
      } else {
        return Left(response.statusMessage ?? "Failed to fetch post");
      }
    } on DioException catch (e) {
      return Left(_handleError(e));
    } catch (e) {
      return Left(e.toString());
    }
  }

  // ---------- Update Post ----------
  @override
  Future<Either<String, bool>> updatePost({
    required String postId,
    required Map<String, dynamic> updatedFields,
  }) async {
    try {
      final response = await dio.put(
        "${ApiUrl.communityPostURL}/$postId",
        data: updatedFields,
        options: await _getOptions(),
      );

      _logger.i("Update post response: ${response.data}");

      if (response.statusCode == 200) {
        return Right(response.data['updated'] == true);
      } else {
        return Left(response.statusMessage ?? "Failed to update post");
      }
    } on DioException catch (e) {
      return Left(_handleError(e));
    } catch (e) {
      return Left(e.toString());
    }
  }

  // ---------- Delete Post ----------
  @override
  Future<Either<String, bool>> deletePost(String postId) async {
    try {
      final response = await dio.delete(
        "${ApiUrl.communityPostURL}/$postId",
        options: await _getOptions(),
      );

      _logger.i("Delete post response: ${response.data}");

      if (response.statusCode == 200) {
        return Right(response.data['deleted'] == true);
      } else {
        return Left(response.statusMessage ?? "Failed to delete post");
      }
    } on DioException catch (e) {
      return Left(_handleError(e));
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, bool>> toggleLike(String postId) async {
    try {
      final response = await dio.put(
        "${ApiUrl.communityPostURL}/$postId/toggle-like",
        options: await _getOptions(),
      );
      _logger.i("Toggle like response: ${response.data}");
      if (response.statusCode == 200) {
        return Right(response.data['isLiked'] as bool);
      } else {
        return Left(response.statusMessage ?? "Failed to toggle like");
      }
    } on DioException catch (e) {
      return Left(_handleError(e));
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, CommentModel>> createComment({
    required String postId,
    required String content,
    String? parentComment,
  }) async {
    try {
      final response = await dio.post(
        "${ApiUrl.communityPostURL}/$postId/comments",
        data: {
          "content": content,
          if (parentComment != null) "parentComment": parentComment,
        },
        options: await _getOptions(),
      );
      _logger.i("Create comment response: ${response.data}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(CommentModel.fromJson(response.data['comment']));
      } else {
        return Left(response.statusMessage ?? "Failed to create comment");
      }
    } on DioException catch (e) {
      return Left(_handleError(e));
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<CommentModel>>> getComments({
    required String postId,
    int skip = 0,
    int limit = 10,
    String? sort,
    String? select,
    String? populate,
  }) async {
    try {
      _logger.i(
        "Fetching comments for post: $postId with skip: $skip, limit: $limit",
      );
      final response = await dio.get(
        "${ApiUrl.communityPostURL}/$postId/comments",
        queryParameters: {
          if (skip > 0) "skip": skip,
          if (limit > 0) "limit": limit,
          if (sort != null) "sort": sort,
          if (select != null) "select": select,
          if (populate != null) "populate": populate,
        },
        options: await _getOptions(),
      );
      _logger.i("Get comments response: ${response.data}");
      if (response.statusCode == 200) {
        final commentsJson = response.data['comments'] as List<dynamic>;
        final comments =
            commentsJson.map((e) => CommentModel.fromJson(e)).toList();
        return Right(comments);
      } else {
        return Left(response.statusMessage ?? "Failed to fetch comments");
      }
    } on DioException catch (e) {
      return Left(_handleError(e));
    } catch (e) {
      return Left(e.toString());
    }
  }

  // ---------- Update Comment ----------
  @override
  Future<Either<String, bool>> updateComment({
    required String postId,
    required String commentId,
    required String content,
  }) async {
    try {
      final response = await dio.put(
        "${ApiUrl.communityPostURL}/$postId/comments/$commentId",
        data: {"content": content},
        options: await _getOptions(),
      );

      _logger.i("Update comment response: ${response.data}");

      if (response.statusCode == 200) {
        return Right(response.data['updated'] == true);
      } else {
        return Left(response.statusMessage ?? "Failed to update comment");
      }
    } on DioException catch (e) {
      return Left(_handleError(e));
    } catch (e) {
      return Left(e.toString());
    }
  }

  // ---------- Delete Comment ----------
  @override
  Future<Either<String, bool>> deleteComment({
    required String postId,
    required String commentId,
  }) async {
    try {
      final response = await dio.delete(
        "${ApiUrl.communityPostURL}/$postId/comments/$commentId",
        options: await _getOptions(),
      );

      _logger.i("Delete comment response: ${response.data}");

      if (response.statusCode == 200) {
        return Right(response.data['deleted'] == true);
      } else {
        return Left(response.statusMessage ?? "Failed to delete comment");
      }
    } on DioException catch (e) {
      return Left(_handleError(e));
    } catch (e) {
      return Left(e.toString());
    }
  }

  // ---------- Get Replies ----------
  @override
  Future<Either<String, List<CommentModel>>> getReplies({
    required String postId,
    required String commentId,
    int skip = 0,
    int limit = 10,
  }) async {
    try {
      final response = await dio.get(
        "${ApiUrl.communityPostURL}/$postId/comments/$commentId/replies",
        queryParameters: {"skip": skip, "limit": limit},
        options: await _getOptions(),
      );

      _logger.i("Get replies response: ${response.data}");

      if (response.statusCode == 200) {
        final repliesJson = response.data['comments'] as List<dynamic>;
        final replies =
            repliesJson.map((e) => CommentModel.fromJson(e)).toList();
        return Right(replies);
      } else {
        return Left(response.statusMessage ?? "Failed to fetch replies");
      }
    } on DioException catch (e) {
      return Left(_handleError(e));
    } catch (e) {
      return Left(e.toString());
    }
  }

  // ---------- Create Reply ----------
  @override
  Future<Either<String, CommentModel>> createReply({
    required String postId,
    required String commentId,
    required String content,
  }) async {
    try {
      final response = await dio.post(
        "${ApiUrl.communityPostURL}/$postId/comments/$commentId/replies",
        data: {"content": content},
        options: await _getOptions(),
      );

      _logger.i("Create reply response: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(CommentModel.fromJson(response.data['comment']));
      } else {
        return Left(response.statusMessage ?? "Failed to create reply");
      }
    } on DioException catch (e) {
      return Left(_handleError(e));
    } catch (e) {
      return Left(e.toString());
    }
  }

  // ---------- Toggle Like on Comment ----------
  @override
  Future<Either<String, bool>> toggleCommentLike({
    required String postId,
    required String commentId,
  }) async {
    try {
      final response = await dio.put(
        "${ApiUrl.communityPostURL}/$postId/comments/$commentId/toggle-like",
        options: await _getOptions(),
      );

      _logger.i("Toggle comment like response: ${response.data}");

      if (response.statusCode == 200) {
        return Right(response.data['isLiked'] as bool);
      } else {
        return Left(response.statusMessage ?? "Failed to toggle comment like");
      }
    } on DioException catch (e) {
      return Left(_handleError(e));
    } catch (e) {
      return Left(e.toString());
    }
  }
}
