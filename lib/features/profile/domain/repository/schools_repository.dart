import 'package:dartz/dartz.dart';

abstract class SchoolRepository {
  Future<Either> getSchoolList(String schoolHint);
}
