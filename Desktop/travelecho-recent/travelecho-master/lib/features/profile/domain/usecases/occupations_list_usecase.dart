import 'package:travelecho/features/profile/domain/repository/occupations_repository.dart';
import 'package:travelecho/service_locator.dart';

class GetOccupations {
  Future getOccupationsList(String occupationHint) {
    final occupationslist =
        sl<OccupationsRepository>().getOccupations(occupationHint);

    return occupationslist;
  }
}
