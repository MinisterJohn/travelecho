import 'package:dartz/dartz.dart';

import '../../milestones_exports.dart';

class LevelRepositoryImpl implements LevelRepository {
  final LevelRemoteDataSource remoteDataSource = sl<LevelRemoteDataSource>();

  LevelRepositoryImpl();

  @override
  @override
  Future<Either<String, List<LevelInfoEntity>>> getLevels() async {
    final nextResult = await remoteDataSource.getNextLevelBadges();

    return nextResult.fold((failure) => Left(failure), (nextMap) {
      final models = LevelInfoModel.fromData(nextJson: nextMap);
      return Right(models);
    });
  }

  @override
  Future<Either<String, List<BadgeEntity>>> getEarnedBadges() async {
    final earnedBadgesResult = await remoteDataSource.getEarnedBadges();

    return earnedBadgesResult.fold((failure) => Left(failure), (badges) {
      final earnedBadgesModel =
          badges.map((badge) => BadgeModel.fromJson(badge)).toList();
      return Right(earnedBadgesModel);
    });
  }
}
