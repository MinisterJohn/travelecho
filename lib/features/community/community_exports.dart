// Community Feature Exports

// Data
export 'data/models/post_model.dart';
export 'data/models/comment_model.dart';

export 'domain/entities/post.dart';
export 'domain/entities/comment.dart';
// Domain Failures
// export 'domain/failures/failure.dart';

// Data Sources
export 'data/sources/community_remote_data_source.dart';
export 'data/sources/community_remote_data_source_impl.dart';
export 'domain/repository/community_repository.dart';
export 'data/repository/community_repository_impl.dart';
// export 'presentation/blocs/community_bloc.dart';
export 'presentation/blocs/post/post_bloc.dart';
export 'presentation/blocs/comment/comment_bloc.dart';
export 'presentation/blocs/reply/reply_bloc.dart';
export 'domain/usecases/replies_usecases.dart';
export 'domain/usecases/posts_usecases.dart';
export 'domain/usecases/toggle_like.dart';
export 'domain/usecases/comment_usecases.dart';
// Presentation
// export 'presentation/blocs/community_bloc.dart';
export 'presentation/pages/community_home_screen.dart';
export 'presentation/pages/profile_id.dart';
export 'presentation/pages/community_page.dart';
export 'presentation/pages/user_profile.dart';
export 'presentation/widgets/comment.dart';
export 'presentation/widgets/post.dart';
export 'presentation/widgets/share.dart';
export 'presentation/pages/create_post_page.dart';
export 'presentation/widgets/create_post/create_post_header.dart';
export 'presentation/widgets/create_post/create_post_tags.dart';
export 'presentation/widgets/create_post/create_post_content.dart';
export 'presentation/widgets/create_post/create_post_visibility.dart';
export 'presentation/widgets/create_post/create_post_handle.dart';
export 'presentation/widgets/create_post/create_post_media.dart';
export 'presentation/utils/tag_utils.dart';
export 'presentation/utils/time_ago.dart';
export 'presentation/utils/get_initials.dart';
export 'presentation/utils/get_random_color.dart';

export "presentation/widgets/post/post_header.dart";
export "presentation/widgets/post/post_content.dart";
export "presentation/widgets/post/post_actions.dart";
export "presentation/widgets/post/post_comments_preview.dart";
export "presentation/pages/post_detail_page.dart";
export "presentation/widgets/post/comment_input_field.dart";
export "domain/entities/reply.dart";
export "data/models/reply_model.dart";
export "presentation/widgets/post_details/reply_section.dart";
export "presentation/widgets/post_details/comment_tile.dart";
export "../features_exports.dart";
