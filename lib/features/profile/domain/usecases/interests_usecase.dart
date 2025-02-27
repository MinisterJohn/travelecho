import 'package:travelecho/features/profile/data/models/interests_model.dart';
import 'package:travelecho/features/profile/domain/repository/interests_repository.dart';
import 'package:travelecho/service_locator.dart';

class GetInterests {
  Future<List<InterestModel>> getInterestsList(String interestHint) async {
    final interestsModel =
        await sl<InterestsRepository>().getInterests(interestHint);

    return interestsModel.toList();
  }
}
