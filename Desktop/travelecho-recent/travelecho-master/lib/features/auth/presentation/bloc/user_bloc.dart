import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelecho/features/auth/domain/usecases/auth_usecases.dart';
import 'package:travelecho/features/auth/presentation/bloc/user_event.dart';
import 'package:travelecho/features/auth/presentation/bloc/user_state.dart';
import 'package:travelecho/service_locator.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SigninUseCase loginUseCase = sl<SigninUseCase>();
  final SignupUseCase signupUseCase = sl<SignupUseCase>();
  // final ResetPassword resetPasswordUseCase;

  AuthBloc() : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        // await loginUseCase(params: {});
        emit(AuthSuccess());
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });

    on<SignupEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        // await signupUseCase(event.email, event.password);
        emit(AuthSuccess());
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });

    // on<ResetPasswordEvent>((event, emit) async {
    //   emit(AuthLoading());
    //   try {
    //     await resetPasswordUseCase(event.email);
    //     emit(AuthSuccess());
    //   } catch (e) {
    //     emit(AuthFailure(e.toString()));
    //   }
    // });
  }
}
