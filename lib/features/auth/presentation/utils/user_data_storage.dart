import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveUserData(Map<String, dynamic> userData) async {
  final prefs = await SharedPreferences.getInstance();
  String jsonString = jsonEncode(userData); // Convert map to JSON string
  await prefs.setString('user_data', jsonString);
}

Future<Map<String, dynamic>?> getUserData() async {
  final prefs = await SharedPreferences.getInstance();
  String? jsonString = prefs.getString('user_data');
  if (jsonString != null) {
    return jsonDecode(jsonString); // Convert back to Map
  }
  return null;
}
