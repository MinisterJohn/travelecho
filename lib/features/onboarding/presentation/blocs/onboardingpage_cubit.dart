import 'package:flutter_bloc/flutter_bloc.dart';

part "onboardingpage_state.dart";


class OnboardingPageCubit extends Cubit<OnboardingPageState> {
  OnboardingPageCubit() : super(InitializeOnboardingPage());

  void changePageIndex(int pageIndex) {
    emit(OnboardingPageUpdated(pageIndex));
  }
}
