import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginStorageUtils {
  static Future<String?> getBiometricPassword(String email) async {
    final storage = FlutterSecureStorage();
    return await storage.read(key: 'biometric_password_$email');
  }

  static Future<void> setBiometricPassword(
    String email,
    String password,
  ) async {
    final storage = FlutterSecureStorage();
    await storage.write(key: 'biometric_password_$email', value: password);
  }

  static Future<String?> getLastBiometricEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('last_biometric_email');
  }

  static Future<void> setLastBiometricEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('last_biometric_email', email);
  }

  static Future<bool> isBiometricsEnabledForEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('biometrics_enabled_$email') ?? false;
  }

  static Future<void> setBiometricsEnabledForEmail(
    String email,
    bool enabled,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('biometrics_enabled_$email', enabled);
  }
}
