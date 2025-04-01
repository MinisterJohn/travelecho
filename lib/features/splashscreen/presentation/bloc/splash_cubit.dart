import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../features_exports.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(DisplaySplash());

  void appStarted() async {
    await Future.delayed(const Duration(seconds: 8));
    var isLoggedIn = await sl<IsLoggedInUseCase>().call();
    var isNotNewUser = await sl<IsNotNewUserUseCase>().call();

    if (isNotNewUser) {
      if (isLoggedIn) {
        emit(Authenticated());
      } else {
        emit(UnAuthenticated());
      }
    } else {
      emit(FirstLaunch());
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
