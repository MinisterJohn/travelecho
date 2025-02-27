import 'package:travelecho/features/profile/data/models/occupations_model.dart';
import 'package:travelecho/features/profile/data/sources/occupations_local_source.dart';
import 'package:travelecho/features/profile/domain/repository/occupations_repository.dart';
import 'package:travelecho/service_locator.dart';

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
