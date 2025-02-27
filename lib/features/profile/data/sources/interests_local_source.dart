import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:travelecho/features/profile/data/models/interests_model.dart';

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
        final String response = await rootBundle.loadString('assets/json/hobbies.json');
        
        if (response.isEmpty) {
          throw Exception('Empty response from hobbies.json');
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
