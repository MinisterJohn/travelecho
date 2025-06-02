import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../profile_exports.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetUserProfileUseCase _getUserProfile = sl<GetUserProfileUseCase>();
  final UpdateProfileImageUseCase _updateProfileImage =
      sl<UpdateProfileImageUseCase>();
  final ProfileRepository _profileRepository = sl<ProfileRepository>();

  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileLoadRequested>(_onProfileLoadRequested);
    on<ProfileImageUpdateRequested>(_onProfileImageUpdateRequested);
    on<ProfileUpdateRequested>(_onProfileUpdateRequested);
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

  Future<void> _onProfileUpdateRequested(
    ProfileUpdateRequested event,
    Emitter<ProfileState> emit,
  ) async {
    if (state is ProfileLoaded) {
      final currentProfile = (state as ProfileLoaded).profile;
      emit(ProfileUpdating());

      try {
        var updateData = {event.updateKey.toString(): event.updateValue};
        if (event.updateKey == ProfileUpdateKey.location) {
          updateData = {"location": event.updateValue};
        } else if (event.updateKey == ProfileUpdateKey.dateOfBirth) {
          updateData = {"dateOfBirth": event.updateValue};
        } else if (event.updateKey == ProfileUpdateKey.school) {
          updateData = {"school": event.updateValue};
        } else if (event.updateKey == ProfileUpdateKey.occupation) {
          updateData = {"occupation": event.updateValue};
        } else if (event.updateKey == ProfileUpdateKey.interests) {
          updateData = {"interests": event.updateValue};
        } else if (event.updateKey == ProfileUpdateKey.languages) {
          updateData = {"languages": event.updateValue};
        }
        print(updateData);
        final result = await _profileRepository.updateUserProfile(updateData);

        result.fold(
          (failure) => emit(ProfileFailure(failure, currentProfile)),
          (updatedProfile) => emit(ProfileLoaded(updatedProfile)),
        );
      } catch (e) {
        emit(ProfileFailure(e.toString(), currentProfile));
      }
    }
  }
}
