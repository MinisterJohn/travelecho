import '../../profile_exports.dart';


class OccupationsRepositoryImpl extends OccupationsRepository {
  final OccupationsLocalSource occupationsLocalSource =
      sl<OccupationsLocalSource>();
  @override
  Future<OccupationsModel> getOccupations(String occupationHint) async {
    final occupationsModel =
        await occupationsLocalSource.fetchOccupations(occupationHint);
    return OccupationsModel(occupations: occupationsModel.toList());
  }
}
