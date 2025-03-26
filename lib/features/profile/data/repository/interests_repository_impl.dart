import '../../profile_exports.dart';

class InterestsRepositoryImpl extends InterestsRepository {
  final InterestLocalSource interestLocalSource = sl<InterestLocalSource>();
  @override
  Future<InterestsModel> getInterests(String interestHint) async {
    final interestsModel =
        await interestLocalSource.fetchInterests(interestHint);
    return InterestsModel(interests: interestsModel.toList());
  }
}
