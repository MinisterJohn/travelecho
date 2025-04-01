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

        await result.fold(
          (error) async {
            emit(AuthFailure(error));
          },
          (data) async {
            final Map userData = data['user'];
            // Store user data in SharedPreferences
            final prefs = await SharedPreferences.getInstance();
            await prefs.setString('user_id', userData['_id']);
            await prefs.setString('user_name', userData['name']);
            await prefs.setString('user_email', userData['email']);
            await prefs.setString('token', userData['token']);
            await prefs.setString('profile_id', userData['profile']);
            await prefs.setBool('is_not_new_user', true);

            emit(AuthSuccess(User(
              id: userData['_id'],
              email: userData['email'],
              fullname: userData['name'],
              profileId: userData['profile'],
              token: userData['token'],
            )));
          },
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

        await result.fold(
          (error) async {
            emit(AuthFailure(error));
          },
          (data) async {
            final Map userData = data['user'];

            // Store user data in SharedPreferences
            final prefs = await SharedPreferences.getInstance();
            await prefs.setString('user_id', userData['id']);
            await prefs.setString('user_name', userData['fullname']);
            await prefs.setString('user_email', userData['email']);
            await prefs.setString('token', userData['token']);
            await prefs.setString('profile_id', userData['profile']);
            await prefs.setBool('is_not_new_user', false);

            emit(AuthSuccess(User(
              id: userData['id'],
              email: userData['email'],
              fullname: userData['fullname'],
              token: userData['token'],
              profileId: userData['profile'],
            )));
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
          final userName = prefs.getString('user_name');
          final userEmail = prefs.getString('user_email');
          final profileId = prefs.getString('profile_id');

          if (userId != null &&
              userName != null &&
              userEmail != null &&
              profileId != null &&
              token != null) {
            emit(AuthSuccess(User(
              id: userId,
              email: userEmail,
              fullname: userName,
              token: token,
              profileId: profileId,
            )));
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
