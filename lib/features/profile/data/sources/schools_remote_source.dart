import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:travelecho/core/network/dio_client.dart';
import 'package:travelecho/features/profile/data/models/schools_list_model.dart';
import 'package:travelecho/service_locator.dart';

abstract class SchoolRemoteSource {
  Future<SchoolListModel> fetchSchoolList(String schoolHint);
}

class SchoolRemoteSourceImpl extends SchoolRemoteSource {
  final Dio dio = Dio();
  @override
  Future<SchoolListModel> fetchSchoolList(String schoolHint) async {
    final response = await dio
        .get("http://universities.hipolabs.com/search?name=$schoolHint");
    Logger().d("School API Response: ${response.data as List<dynamic>}");
    if (response.statusCode == 200 && response.data is List) {
      final schoolList = SchoolListModel.fromJson(response.data as List<dynamic>);
      Logger().d("Parsed School List: $schoolList");
      return schoolList;
    } else {
      throw Exception("Failed to get schools");
    }
  }
}
