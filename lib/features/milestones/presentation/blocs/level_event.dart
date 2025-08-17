part of 'level_bloc.dart';

abstract class LevelEvent {}

class FetchLevels extends LevelEvent {}

class FetchEarnedBadges extends LevelEvent {}
class FetchLevelByBadge extends LevelEvent {
  final BadgeEntity badge;
  FetchLevelByBadge(this.badge);
}

