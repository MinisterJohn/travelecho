import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_bloc/flutter_bloc.dart';
import "../../features/features_exports.dart";
import 'package:travelecho/navigation_menu/blocs/navigation_menu_cubit.dart';
import 'package:travelecho/features/home/presentation/pages/homescreen.dart';
import 'package:line_icons/line_icons.dart';

class RootPage extends StatefulWidget {
  final int? initialPage;
  const RootPage({super.key, this.initialPage = 0});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  late PageController _pageController;
  int currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialPage ?? 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return const HomeScreen();

      case 1:
        return const TripScreen(); // bloc is provided above now

      case 2:
        return const BudgetTracker(); // bloc is provided above now

      case 3:
        return const MemoriesHomePage(); // bloc is provided above now

      case 4:
        return const CommunityHomeScreen();

      case 5:
        return const ProfilePage(); // bloc is provided above now

      default:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Navigation state
        BlocProvider.value(value: sl<NavigationMenuCubit>()),

        // Trip page
        BlocProvider(create: (_) => sl<AirportBloc>()),
        BlocProvider(create: (_) => sl<FlightBookingBloc>()),

        // Budget tracker
        BlocProvider(create: (_) => sl<BudgetBloc>()),
        BlocProvider(create: (_) => sl<CurrencyBloc>()),

        // Memories page
        BlocProvider(create: (_) => sl<MemoriesBloc>()),
        BlocProvider(create: (_) => sl<DataSearchBloc>()),
        BlocProvider(create: (_) => sl<ProfileBloc>()),
        BlocProvider(create: (_) => sl<LevelBloc>()..add(FetchLevels())),

        // Profile page
        BlocProvider(create: (_) => sl<TravelDocumentBloc>()),
        BlocProvider(create: (_) => sl<AuthBloc>()),

         BlocProvider<PostBloc>(create: (_) => PostBloc()),
    BlocProvider<CommentBloc>(create: (_) => CommentBloc()),
    BlocProvider<ReplyBloc>(create: (_) => ReplyBloc()),
      ],
      child: Scaffold(
        body: SafeArea(
          child: PageView.builder(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 6,
            itemBuilder: (context, index) => _buildPage(index),
            onPageChanged: (index) {
              setState(() => currentPageIndex = index);
            },
          ),
        ),
        bottomNavigationBar: NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: currentPageIndex,
          destinations: const [
            NavigationDestination(icon: Icon(LineIcons.home), label: "Explore"),
            NavigationDestination(icon: Icon(LineIcons.plane), label: "Trip"),
            NavigationDestination(
              icon: Icon(LineIcons.piggyBank),
              label: "Budget",
            ),
            NavigationDestination(
              icon: Icon(LineIcons.image),
              label: "Memories",
            ),
            NavigationDestination(
              icon: Icon(LineIcons.users),
              label: "Community",
            ),
            NavigationDestination(
              icon: Icon(LineIcons.userCircle),
              label: "Profile",
            ),
          ],
          onDestinationSelected: (index) {
            _pageController.jumpToPage(index);
          },
        ),
      ),
    );
  }
}
