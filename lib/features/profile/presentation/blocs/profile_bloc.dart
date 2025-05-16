import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../profile_exports.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetUserProfileUseCase _getUserProfile =
      sl<GetUserProfileUseCase>();
  final UpdateProfileImageUseCase _updateProfileImage =
      sl<UpdateProfileImageUseCase>();

  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileLoadRequested>(_onProfileLoadRequested);
    on<ProfileImageUpdateRequested>(_onProfileImageUpdateRequested);
  }

  Future<void> _onProfileLoadRequested(
    ProfileLoadRequested event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());
    try {
      final result = await _getUserProfile();
      result.fold(
        (failure) => emit(ProfileFailure(failure)),
        (profile) => emit(ProfileLoaded(profile)),
      );
    } catch (e) {
      emit(ProfileFailure(e.toString()));
    }
  }

  Future<void> _onProfileImageUpdateRequested(
    ProfileImageUpdateRequested event,
    Emitter<ProfileState> emit,
  ) async {
    if (state is ProfileLoaded) {
      final currentProfile = (state as ProfileLoaded).profile;
      emit(ProfileImageUploading(currentProfile));

      try {
        final result = await _updateProfileImage(event.imageFile);
        result.fold(
          (failure) => emit(ProfileFailure(failure, currentProfile)),
          (response) {
            final imageUrl = response['imageUrl'] as String;
            emit(ProfileImageUploaded(currentProfile, imageUrl));
          },
        );
      } catch (e) {
        emit(ProfileFailure(e.toString(), currentProfile));
      }
    }
  }
}
