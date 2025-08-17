import 'package:flutter_bloc/flutter_bloc.dart';
import "../../milestones_exports.dart";

part 'level_event.dart';
part 'level_state.dart';

class LevelBloc extends Bloc<LevelEvent, LevelState> {
  final GetLevelsUseCase getLevels = sl<GetLevelsUseCase>();
  final GetEarnedBadgesUseCase getEarnedBadges = sl<GetEarnedBadgesUseCase>();

  LevelBloc() : super(LevelInitial()) {
    // Fetch Levels
    on<FetchLevels>((event, emit) async {
      emit(LevelLoading());
      final result = await getLevels();
      result.fold(
        (error) => emit(LevelError(error)),
        (levels) => emit(LevelLoaded(levels)),
      );
    });

    // Fetch Earned Badges
    on<FetchEarnedBadges>((event, emit) async {
      emit(LevelLoading());
      final result = await getEarnedBadges();
      result.fold(
        (error) => emit(LevelError(error)),
        (badges) => emit(EarnedBadgesLoaded(badges)),
      );
    });
    on<FetchLevelByBadge>((event, emit) async {
      emit(LevelLoading());
      final result = await getLevels(); // reuse the same usecase
      result.fold((error) => emit(LevelError(error)), (levels) {
        // find the level that matches this badge
        final level = levels.firstWhere(
          (lvl) => lvl.currentBadge?.id == event.badge.id,
          orElse: () => throw Exception("Level not found for badge"),
        );
        emit(LevelLoaded([level])); // emit only that level
      });
    });
  }
}
