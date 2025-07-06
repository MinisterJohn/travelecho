import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../budget_exports.dart';

class ExpenseReceiptUploadHandler {
  final SharedPreferences _prefs = sl<SharedPreferences>();

  Future<String?> _getToken() async {
    final token = _prefs.getString('token');
    return token != null && token.isNotEmpty ? 'Bearer $token' : null;
  }

  Future<Either<String, String>> uploadReceipt({
    required String expenseId,
    required String filePath,
  }) async {
    try {
      final token = await _getToken();
      if (token == null) return const Left('Authentication token is missing');

      final uri = Uri.parse(ApiUrl.fullUrl(ApiUrl.dynamicExpenseReceiptURL(expenseId)));
      final request = http.MultipartRequest('POST', uri)
        ..headers['Authorization'] = token;

      print('Uploading receipt for expense ID: $expenseId');

      final multipartFile = await http.MultipartFile.fromPath('receipt', filePath);
      request.files.add(multipartFile);
      request.fields['expenseId'] = expenseId;
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      // print("Response status: ", response.statusCode);
      // print("Response body: ", responseBody);

      if (response.statusCode == 200) {
        final data = jsonDecode(responseBody);
        return Right(data['receiptUrl'] ?? '');
      } else {
        try {
          final errorData = jsonDecode(responseBody);
          return Left(errorData['message'] ?? 'Upload failed');
        } catch (_) {
          return Left('Upload failed with status: \\${response.statusCode}');
        }
      }
    } catch (e) {
      return Left('Unexpected error: $e');
    }
  }
}
