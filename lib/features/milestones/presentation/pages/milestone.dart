import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../milestones_exports.dart';

class MilestonePage extends StatefulWidget {
  final String badgeImageUrl;
  final BadgeEntity badge;

  const MilestonePage({
    super.key,
    required this.badgeImageUrl,
    required this.badge,
  });

  @override
  State<MilestonePage> createState() => _MilestonePageState();
}

class _MilestonePageState extends State<MilestonePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LevelBloc>().add(FetchLevelByBadge(widget.badge));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: setAppBar("Last Earned Badge: ${widget.badge.name}", context),
      body: BlocBuilder<LevelBloc, LevelState>(
        builder: (context, state) {
          if (state is LevelLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LevelLoaded && state.levels.isNotEmpty) {
            final level = state.levels.first;
            final badge = level.currentBadge!;
            final nextBadge = level.nextBadge;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MilestoneHeader(badge: badge, imageUrl: widget.badgeImageUrl),
                  MilestoneInfo(
                    badge: badge,
                    requirementText: getRequirementText(badge),
                  ),
                  if (nextBadge != null) NextBadgeSection(nextBadge: nextBadge),
                  MilestoneProgress(level: level, badge: badge),
                ],
              ),
            );
          } else if (state is LevelError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
