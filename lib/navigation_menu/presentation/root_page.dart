import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_bloc/flutter_bloc.dart';
import "../../features/features_exports.dart";
import 'package:travelecho/navigation_menu/blocs/navigation_menu_cubit.dart';
import 'package:travelecho/features/home/presentation/pages/homescreen.dart';
import 'package:line_icons/line_icons.dart';

class RootPage extends StatefulWidget {
  final int? initialPage;
  static const int MEMORIES_PAGE_INDEX = 3;

  const RootPage({super.key, this.initialPage = 0});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int currentPage = 0;
  @override
  void initState() {
    super.initState();
    currentPage = widget.initialPage ?? 0;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NavigationMenuCubit>().changePage(currentPage);
    });
  }

  final List<Widget> pages = [
    // Container(),
    const HomeScreen(),
    // Container(),
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<AirportBloc>()),
        BlocProvider(create: (context) => sl<FlightBookingBloc>()),
      ],
      child: const TripScreen(),
    ),
    // Container(),
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<BudgetBloc>()),
        BlocProvider(create: (context) => sl<CurrencyBloc>()),
      ],
      child: const BudgetTracker(), // Your Budget page widget
    ), // Replace with your Budget page widget
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<MemoriesBloc>()),
        BlocProvider(create: (context) => sl<DataSearchBloc>()),
        BlocProvider(create: (context) => sl<ProfileBloc>()),
      ],
      child: const MemoriesHomePage(),
    ),
    // Container(),
    const CommunityPage(),

    // Container(),
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<ProfileBloc>()),
        BlocProvider(create: (context) => sl<TravelDocumentBloc>()),
      ],
      child: const ProfilePage(),
    ), // Replace with your Profile page widget
  ];
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: sl<NavigationMenuCubit>(),
      child: BlocBuilder<NavigationMenuCubit, NavigationMenuState>(
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: SizedBox.expand(
                child: IndexedStack(
                  index: state.currentPageIndex,
                  children: pages,
                ),
              ),
            ),
            bottomNavigationBar: NavigationBar(
              height: 80,
              elevation: 0,
              destinations: const [
                NavigationDestination(
                  icon: Icon(LineIcons.home),
                  label: "Explore",
                ),
                NavigationDestination(
                  icon: Icon(LineIcons.plane),
                  label: "Trip",
                ),
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
              onDestinationSelected: (int index) {
                context.read<NavigationMenuCubit>().changePage(index);
              },
              selectedIndex: state.currentPageIndex,
            ),
          );
        },
      ),
    );
  }
}
