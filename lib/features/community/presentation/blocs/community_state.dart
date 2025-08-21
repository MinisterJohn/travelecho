part of 'community_bloc.dart';

abstract class CommunityState extends Equatable {
  const CommunityState();

  @override
  List<Object?> get props => [];
}

class CommunityInitial extends CommunityState {}

class CommunityLoading extends CommunityState {}

class CommunityLoadingComments extends CommunityState {}

class CommunityLoadingReplies extends CommunityState {}

class CommunityPostsLoaded extends CommunityState {
  final List<PostModel> posts;
  const CommunityPostsLoaded(this.posts);

  @override
  List<Object?> get props => [posts];
}

class CommunityError extends CommunityState {
  final String message;
  final List<PostModel> posts;

  const CommunityError(this.message, {this.posts = const []});

  @override
  List<Object?> get props => [message, posts];
}
