import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelecho/features/auth/domain/usecases/auth_usecases.dart';
import 'package:travelecho/features/splashscreen/presentation/bloc/splash_state.dart';
import 'package:travelecho/service_locator.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(DisplaySplash());

  void appStarted() async {
    await Future.delayed(const Duration(seconds: 8));
    var isLoggedIn = await sl<IsLoggedInUseCase>().call();
    var isNotNewUser = await sl<IsNotNewUserUseCase>().call();

    if (isNotNewUser) {
      emit(UnAuthenticated());
      // emit(FirstLaunch());
      return;
    }

    if (isLoggedIn) {
      emit(Authenticated());
    } else {
      emit(UnAuthenticated());
    }
  }
}
