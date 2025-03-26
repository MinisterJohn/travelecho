import 'package:dartz/dartz.dart';

abstract class LocationRepository {
  Future<Either> getLocationList(String locationHint);
}
