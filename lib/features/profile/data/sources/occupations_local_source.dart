import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:travelecho/features/profile/data/models/occupations_model.dart';

abstract class OccupationsLocalSource {
  Future<OccupationsModel> fetchOccupations(String occupationHint);
}

class OccupationsLocalSourceImpl extends OccupationsLocalSource {
  OccupationsModel allOccupations = OccupationsModel(occupations: []);
  OccupationsModel sortedOccupations = OccupationsModel(occupations: []);

  @override
  Future<OccupationsModel> fetchOccupations(String occupationHint) async {
    if (allOccupations.occupations.isEmpty) {
      final String response =
          await rootBundle.loadString('assets/json/occupations.json');
      final Map<String, dynamic> occupationsJsonData = json.decode(response);
      allOccupations = OccupationsModel.fromJson(occupationsJsonData);
    }
    sortedOccupations = OccupationsModel.sort(allOccupations, occupationHint);
    return sortedOccupations;
  }
}
