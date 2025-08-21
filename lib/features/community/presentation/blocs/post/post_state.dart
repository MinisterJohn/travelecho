part of 'post_bloc.dart';

abstract class PostState {}

class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostsLoaded extends PostState {
  final List<PostModel> posts;
  PostsLoaded(this.posts);
}

class PostLoaded extends PostState {
  final PostModel post;
  PostLoaded(this.post);
}

class PostError extends PostState {
  final String message;
  PostError(this.message);
}
