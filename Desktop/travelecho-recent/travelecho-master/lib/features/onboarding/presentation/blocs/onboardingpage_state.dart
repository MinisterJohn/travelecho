abstract class OnboardingPageState {
  final int currentPage;
  const OnboardingPageState({required this.currentPage});
}

class InitializeOnboardingPage extends OnboardingPageState {
  InitializeOnboardingPage() : super(currentPage: 0);
}

class OnboardingPageUpdated extends OnboardingPageState {
  OnboardingPageUpdated(int newIndex) : super(currentPage: newIndex);
}
