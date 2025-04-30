import 'dart:convert';
import 'package:flutter/services.dart';
import '../../profile_exports.dart';

abstract class InterestLocalSource {
  Future<InterestsModel> fetchInterests(String interestHint);
}

class InterestLocalSourceImpl extends InterestLocalSource {
  InterestsModel allInterests = const InterestsModel(interests: []);
  InterestsModel sortedInterests = const InterestsModel(interests: []);

  @override
  Future<InterestsModel> fetchInterests(String interestHint) async {
    if (allInterests.interests.isEmpty) {
      try {
        final String response =
            await rootBundle.loadString('assets/json/interests.json');
        if (response.isEmpty) {
          throw Exception('Empty response from interests.json');
        }
        final List<dynamic> interestsJsonData = json.decode(response);
        allInterests = InterestsModel.fromJson(interestsJsonData);
      } catch (e) {
        throw Exception('Error loading interests: $e');
      }
    }

    sortedInterests = InterestsModel.sort(allInterests, interestHint);
    return sortedInterests;
  }
}
