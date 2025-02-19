import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelecho/features/auth/domain/usecases/auth_usecases.dart';
import 'package:travelecho/features/auth/presentation/bloc/user_event.dart';
import 'package:travelecho/features/auth/presentation/bloc/user_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SigninUseCase loginUseCase;
  final SignupUseCase signupUseCase;
  // final ResetPassword resetPasswordUseCase;

  AuthBloc({
    required this.loginUseCase,
    required this.signupUseCase,
    // required this.resetPasswordUseCase,
  }) : super(AuthInitial()) {
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
