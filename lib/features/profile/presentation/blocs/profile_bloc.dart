import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelecho/features/profile/presentation/blocs/profile_event.dart';
import 'package:travelecho/features/profile/presentation/blocs/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileRequested>((event, emit) {
      emit(ProfileLoading());

      // emit(ProfileLoaded(profile))
    });
  }
}
