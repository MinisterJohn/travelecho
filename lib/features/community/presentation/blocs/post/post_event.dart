part of 'post_bloc.dart';

abstract class PostEvent {}

class CreatePostEvent extends PostEvent {
  final FormData formData;
  CreatePostEvent(this.formData);
}
class CreatePostWithMediaEvent extends PostEvent {
  final FormData formData;
  final List<File> mediaFiles;

  CreatePostWithMediaEvent({required this.formData, required this.mediaFiles});
}


class GetPostsEvent extends PostEvent {
  final int skip;
  final int limit;
  GetPostsEvent({this.skip = 0, this.limit = 20});
}

class GetPostByIdEvent extends PostEvent {
  final String postId;
  GetPostByIdEvent(this.postId);
}

class TogglePostLikeEvent extends PostEvent {
  final String postId;
  TogglePostLikeEvent(this.postId);
}

class UpdatePostEvent extends PostEvent {
  final String postId;
  final Map<String, dynamic> updatedFields;
  UpdatePostEvent(this.postId, this.updatedFields);
}

class DeletePostEvent extends PostEvent {
  final String postId;
  DeletePostEvent(this.postId);
}
