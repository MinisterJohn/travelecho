import 'package:flutter/material.dart' hide CarouselController;
import "package:flutter/services.dart";
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
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Transparent status bar
      statusBarIconBrightness: Brightness.dark, // Black icons
      systemNavigationBarColor:
          Colors.white, // Optional: Change navigation bar color
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SplashCubit()..appStarted(),
          ),
          BlocProvider(
            create: (context) => sl<AuthBloc>()..add(CheckAuthStatus()),
          ),
        ],
        child: ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (_, child) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Travel Echo',
            theme: AppTheme.appTheme,
            // Define routes for navigation using aliases

            home: const SplashScreen(), 
          ),
        ));
  }
}
