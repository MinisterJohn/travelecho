import 'package:dartz/dartz.dart';
import '../../milestones_exports.dart';

class GetEarnedBadgesUseCase {
  final LevelRepository repository = sl<LevelRepository>();

  GetEarnedBadgesUseCase();

  Future<Either<String, List<BadgeEntity>>> call() {
    return repository.getEarnedBadges();
  }
}
