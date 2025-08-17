import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../milestones_exports.dart';

class MilestonesPage extends StatefulWidget {
  const MilestonesPage({super.key});

  @override
  State<MilestonesPage> createState() => _MilestonesPageState();
}

class _MilestonesPageState extends State<MilestonesPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LevelBloc>().add(FetchEarnedBadges());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final route = ModalRoute.of(context);
    if (route is PageRoute) {
      routeObserver.subscribe(this, route);
    }
  }

  @override
  void didPopNext() {
    context.read<LevelBloc>().add(FetchEarnedBadges());
  }

  @override
  Widget build(BuildContext context) {
    final prefs = sl<SharedPreferences>();
    final username = prefs.getString('name');

    return Scaffold(
      appBar: setAppBar("Milestones", context),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            EarnedBadgesSection(username: username),
            WidgetsSpacer.verticalSpacer16,
            // const MilestonesProgressSection(s),
          ],
        ),
      ),
    );
  }
}
