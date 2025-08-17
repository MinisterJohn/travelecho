import 'package:dartz/dartz.dart';
import '../../milestones_exports.dart';

class GetLevelsUseCase {
  final LevelRepository repository = sl<LevelRepository>();

  GetLevelsUseCase();

  Future<Either<String, List<LevelInfoEntity>>> call() {
    return repository.getLevels();
  }
}
