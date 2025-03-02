import 'package:travelecho/features/profile/data/models/interests_model.dart';
import 'package:travelecho/features/profile/data/sources/interests_local_source.dart';
import 'package:travelecho/features/profile/domain/repository/interests_repository.dart';
import 'package:travelecho/service_locator.dart';

class InterestsRepositoryImpl extends InterestsRepository {
  final InterestLocalSource interestLocalSource = sl<InterestLocalSource>();
  @override
  Future<InterestsModel> getInterests(String interestHint) async {
    final interestsModel =
        await interestLocalSource.fetchInterests(interestHint);
    return InterestsModel(interests: interestsModel.toList());
  }
}
