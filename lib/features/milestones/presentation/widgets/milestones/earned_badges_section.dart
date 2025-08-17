import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../milestones_exports.dart';

class EarnedBadgesSection extends StatelessWidget {
  final String? username;
  const EarnedBadgesSection({super.key, this.username});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LevelBloc, LevelState>(
      buildWhen:
          (prev, curr) =>
              curr is EarnedBadgesLoaded ||
              curr is LevelLoading ||
              curr is LevelError,
      builder: (context, state) {
        if (state is LevelLoading) {
          return Positioned(
            top: 8,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Loading badges...',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        if (state is LevelError) {
          return Positioned(
            top: 8,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.refresh, color: Colors.white, size: 18),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Error loading badges. Tap to refresh.',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.refresh,
                        color: Colors.white,
                        size: 18,
                      ),
                      onPressed: () {
                        context.read<LevelBloc>().add(FetchEarnedBadges());
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        if (state is EarnedBadgesLoaded) {
          final earnedBadges = state.badges;
          if (earnedBadges.isEmpty) return const NoMileStonePage();

          // Group by category
          final Map<String, List<BadgeEntity>> byCategory = {};
          for (final b in earnedBadges) {
            byCategory.putIfAbsent(b.category, () => []).add(b);
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EarnedBadgesHeader(
                username: username,
                totalCount: earnedBadges.length,
              ),
              WidgetsSpacer.verticalSpacer32,
              ...byCategory.entries.map(
                (e) => CategoryBadgeGroup(category: e.key, badges: e.value),
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
