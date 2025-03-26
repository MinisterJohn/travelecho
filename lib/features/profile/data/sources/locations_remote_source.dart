import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import '../../profile_exports.dart';

abstract class LocationRemoteSource {
  Future<LocationListModel> fetchLocationList(String locationHint);
}

class LocationRemoteSourceImpl extends LocationRemoteSource {
  final Dio dio = Dio();
  @override
  Future<LocationListModel> fetchLocationList(String locationHint) async {
    final response = await dio.get(
        "https://api.geoapify.com/v1/geocode/autocomplete?text=$locationHint&apiKey=3917c3ebc82b4c36b8b36b0d5610a2c7");
    Logger().d("Location API Response: ${response.data["features"]  as List<dynamic>}");
    if (response.statusCode == 200) {
      final locationList =
          LocationListModel.fromJson(response.data["features"] as List<dynamic>);
      Logger().d("Parsed Location List: $locationList");
      return locationList;
    } else {
      throw Exception("Failed to get locations");
    }
  }
}
