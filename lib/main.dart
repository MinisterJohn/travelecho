import 'package:flutter/material.dart' hide CarouselController;
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "features/features_exports.dart";

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SplashCubit()..appStarted()),
        BlocProvider(
          create: (context) => sl<AuthBloc>()..add(CheckAuthStatus()),
        ),
        BlocProvider(
          create:
              (context) => LocationSuggestionCubit(
                GetLocationSuggestionsUseCase(
                  LocationSuggestionRepositoryImpl(
                    LocationRemoteDataSource(
                      '3917c3ebc82b4c36b8b36b0d5610a2c7',
                    ),
                  ),
                ),
              ),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder:
            (_, child) => MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Travel Echo',
              theme: AppTheme.appTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: ThemeMode.light,
              home: const SplashScreen(),
              navigatorObservers: [routeObserver],
            ),
      ),
    );
  }
}
