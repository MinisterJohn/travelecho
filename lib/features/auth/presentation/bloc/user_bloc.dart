import 'package:flutter_bloc/flutter_bloc.dart';
import '../../auth_exports.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'user_event.dart';
part 'user_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SigninUseCase loginUseCase = sl<SigninUseCase>();
  final SignupUseCase signupUseCase = sl<SignupUseCase>();
  final IsLoggedInUseCase isLoggedInUseCase = sl<IsLoggedInUseCase>();
  final VerifyOtpUseCase verifyOtpUseCase = sl<VerifyOtpUseCase>();
  final SendOtpUseCase sendOtpUseCase = sl<SendOtpUseCase>();
  final ResetPasswordUseCase resetPasswordUseCase = sl<ResetPasswordUseCase>();

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
        print("result $result");
        await result.fold(
          (error) async {
            emit(AuthFailure(error.toString()));
          },
          (data) async {
            print("data $data");

            final Map userData = data['user'];
            // Store user data in SharedPreferences

            emit(AuthLoginSuccess(User(
              id: userData['_id'],
              token: userData['token'],
              name: userData['name'],
              email: userData['email'],
              verified: userData['verified'],
              plan: userData['plan'],
              subscription: userData['subscription'],
              profile: Profile.fromJson(userData['profile']),
              createdAt: DateTime.parse(userData['createdAt']),
              updatedAt: DateTime.parse(userData['updatedAt']),
              role: userData['role'],
            )));
          },
        );
      } catch (e) {
        print("Login event error: $e"); // Debug log
        emit(AuthFailure(e.toString()));
      }
    });

    on<SignupEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final result = await signupUseCase.call(
          params: SignupReqParams(
            email: event.email.trim(),
            password: event.password,
            name: event.name.trim(),
          ),
        );

        await result.fold(
          (error) async {
            emit(AuthFailure(error));
          },
          (data) async {
            emit(AuthSignupSuccess(email: event.email));
          },
        );
      } catch (e) {
        print("Signup event error: $e"); // Debug log
        emit(AuthFailure("An unexpected error occurred during signup"));
      }
    });

    on<CheckAuthStatus>((event, emit) async {
      emit(AuthLoading());
      try {
        var isLoggedIn = await sl<IsLoggedInUseCase>().call();
        final prefs = await SharedPreferences.getInstance();
        // print("token $token");

        if (isLoggedIn) {
          final token = prefs.getString('token');
          final userId = prefs.getString('user_id');

          if (userId != null && token != null) {
            emit(AuthSuccess());
          } else {
            // If we have a token but missing other data, clear everything and start fresh
            await prefs.clear();
            emit(AuthInitial());
          }
        } else {
          emit(AuthInitial());
        }
      } catch (e) {
        print("CheckAuthStatus error: $e");
        emit(AuthFailure("Failed to check authentication status"));
      }
    });

    on<VerifyOtpEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final result = await verifyOtpUseCase.call(
          params: {
            'email': event.email,
            'otp': event.otp,
          },
        );

        result.fold(
          (error) => emit(AuthFailure(error)),
          (success) => emit(AuthSuccess()),
        );
      } catch (e) {
        print("OTP verification error: $e");
        emit(AuthFailure(
            "An unexpected error occurred during OTP verification"));
      }
    });

    on<ResetPasswordEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final result = await resetPasswordUseCase.call(
          params: {
            'email': event.email,
            'password': event.password,
            'confirmPassword': event.confirmPassword,
          },
        );

        result.fold(
          (error) => emit(AuthFailure(error)),
          (data) => emit(AuthSuccess()),
        );
      } catch (e) {
        print("Reset Password error: $e");
        emit(AuthFailure("Failed to reset password: $e"));
      }
    });

    on<SendOtpEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final result = await sendOtpUseCase.call(params: event.email);
        result.fold(
          (error) => emit(AuthFailure(error)),
          (success) => emit(AuthSuccess()),
        );
      } catch (e) {
        print("Send OTP error: $e");
        emit(AuthFailure("Failed to send OTP: $e"));
      }
    });
  }
}
