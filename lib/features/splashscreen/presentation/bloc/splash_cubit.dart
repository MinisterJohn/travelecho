import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../features_exports.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(DisplaySplash());

  void appStarted() async {
    await Future.delayed(const Duration(seconds: 8));
    final prefs = await SharedPreferences.getInstance();
    bool isNotNewUser = prefs.getBool('is_not_new_user') ?? false;

    // If it's the first launch, set the flag so user never sees onboarding again
    if (!isNotNewUser) {
      await prefs.setBool('is_not_new_user', true);
      emit(FirstLaunch());
      return;
    }

    var isLoggedIn = await sl<IsLoggedInUseCase>().call();
    if (isLoggedIn) {
      emit(Authenticated());
    } else {
      emit(UnAuthenticated());
    }
  }

  // void checkAuthStatus() async {
  //   var isLoggedIn = await sl<IsLoggedInUseCase>().call();
  //   if (isLoggedIn) {
  //     emit(Authenticated());
  //   } else {
  //     emit(UnAuthenticated());
  //   }
  // }
}
