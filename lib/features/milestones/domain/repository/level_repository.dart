import 'package:dartz/dartz.dart';

import '../entities/level_info.dart';
import '../entities/badge.dart';

abstract class LevelRepository {
  Future<Either<String, List<LevelInfoEntity>>> getLevels();
  Future<Either<String, List<BadgeEntity>>> getEarnedBadges();
}
