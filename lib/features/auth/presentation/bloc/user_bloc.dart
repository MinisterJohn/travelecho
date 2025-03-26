import 'package:flutter_bloc/flutter_bloc.dart';
import '../../auth_exports.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'user_event.dart';
part 'user_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SigninUseCase loginUseCase = sl<SigninUseCase>();
  final SignupUseCase signupUseCase = sl<SignupUseCase>();
  final IsLoggedInUseCase isLoggedInUseCase = sl<IsLoggedInUseCase>();
  // final ResetPassword resetPasswordUseCase;

  AuthBloc() : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final result = await loginUseCase.call(
          params: SigninReqParams(
            email: event.email.trim(),
            password: event.password,
          ),
        );

        result.fold(
          (error) => emit(AuthFailure(error)),
          (data) => emit(AuthSuccess(User(
            id: data['user']['id'],
            email: data['user']['email'],
            fullname: data['user']['fullname'],
            token: data['user']['token'],
          ))),
        );
      } catch (e) {
        print("Login event error: $e"); // Debug log
        emit(AuthFailure("An unexpected error occurred during login"));
      }
    });

    on<SignupEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final result = await signupUseCase.call(
          params: SignupReqParams(
            email: event.email.trim(),
            password: event.password,
            name: event.fullname.trim(),
          ),
        );

        result.fold(
          (error) => emit(AuthFailure(error)),
          (data) => emit(AuthSuccess(User(
            id: data['user']['id'],
            email: data['user']['email'],
            fullname: data['user']['fullname'],
            token: data['user']['token'],
          ))),
        );
      } catch (e) {
        print("Signup event error: $e"); // Debug log
        emit(AuthFailure("An unexpected error occurred during signup"));
      }
    });

    on<CheckAuthStatus>((event, emit) async {
      emit(AuthLoading());
      try {
        final isLoggedIn = await isLoggedInUseCase();
        if (isLoggedIn) {
          // Get stored user data
          final prefs = await SharedPreferences.getInstance();
          final userId = prefs.getString('user_id');
          final userName = prefs.getString('user_name');
          final userEmail = prefs.getString('user_email');
          final token = prefs.getString('token');

          if (userId != null &&
              userName != null &&
              userEmail != null &&
              token != null) {
            emit(
              AuthSuccess(
                User(
                  id: userId,
                  email: userEmail,
                  fullname: userName,
                  token: token,
                ),
              ),
            );
          } else {
            emit(AuthFailure("Stored authentication data is incomplete"));
          }
        } else {
          emit(AuthInitial());
        }
      } catch (e) {
        print("CheckAuthStatus error: $e");
        emit(AuthFailure("Failed to check authentication status"));
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
