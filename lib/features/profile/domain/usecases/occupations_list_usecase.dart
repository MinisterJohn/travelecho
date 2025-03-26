import '../../profile_exports.dart';


class GetOccupations {
  Future getOccupationsList(String occupationHint) {
    final occupationslist =
        sl<OccupationsRepository>().getOccupations(occupationHint);

    return occupationslist;
  }
}
