import '../../profile_exports.dart';


class GetInterests {
  Future<List<InterestModel>> getInterestsList(String interestHint) async {
    final interestsModel =
        await sl<InterestsRepository>().getInterests(interestHint);

    return interestsModel.toList();
  }
}
