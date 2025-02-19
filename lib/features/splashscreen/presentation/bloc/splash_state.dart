import 'package:shared_preferences/shared_preferences.dart';

abstract class SplashState {}

class DisplaySplash extends SplashState {}

class FirstLaunch extends SplashState {}

class Authenticated extends SplashState {}

class UnAuthenticated extends SplashState {}