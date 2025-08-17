part of 'level_bloc.dart';

abstract class LevelState {}

class LevelInitial extends LevelState {}

class LevelLoading extends LevelState {}

class LevelLoaded extends LevelState {
  final List<LevelInfoEntity> levels;
  LevelLoaded(this.levels);
}

class EarnedBadgesLoaded extends LevelState {
  final List<BadgeEntity> badges;
  EarnedBadgesLoaded(this.badges);
}

class LevelError extends LevelState {
  final String message;
  LevelError(this.message);
}
