import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:travelecho/features/budget/data/budget_data.dart';
import "../../features/features_exports.dart";
import 'package:travelecho/navigation_menu/blocs/navigation_menu_cubit.dart';
import 'package:travelecho/features/home/presentation/pages/homescreen.dart';
import 'package:travelecho/features/budget/budget_tracker.dart';
import 'package:line_icons/line_icons.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int currentPage = 0;
  final List<Widget> pages = [
    // Container(),
    const HomeScreen(),
    // Container(),
    MultiBlocProvider(providers: [
      BlocProvider(
          create: (context) => sl<TokenAuthBloc>()..add(FetchTokenAuthToken())),
      BlocProvider(create: (context) => sl<AirportBloc>()),
      BlocProvider(create: (context) => sl<FlightBookingBloc>()),
    ], child: const TripScreen()),
    // Container(),
    ChangeNotifierProvider(
      create: (context) => BudgetsData(), // No semicolon here
      child: const BudgetTracker(), // Your Budget page widget
    ), // Replace with your Budget page widget
    // Container(),
    MemoryPage(),
    // Container(),
    const CommunityPage(),
    // Container(),

    const ProfilePage(), // Replace with your Profile page widget
  ];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavigationMenuCubit(),
      child: BlocBuilder<NavigationMenuCubit, NavigationMenuState>(
        builder: (context, state) {
          return Scaffold(
            body: SizedBox.expand(
                child: IndexedStack(
                    index: state.currentPageIndex, children: pages)),
            bottomNavigationBar: NavigationBar(
              height: 80,
              elevation: 0,
              destinations: const [
                NavigationDestination(
                    icon: Icon(LineIcons.home), label: "Explore"),
                NavigationDestination(
                  icon: Icon(LineIcons.plane),
                  label: "Trip",
                ),
                NavigationDestination(
                  icon: Icon(LineIcons.piggyBank),
                  label: "Budget",
                ),
                NavigationDestination(
                    icon: Icon(LineIcons.image), label: "Memories"),
                NavigationDestination(
                    icon: Icon(LineIcons.users), label: "Community"),
                NavigationDestination(
                    icon: Icon(LineIcons.userCircle), label: "Profile"),
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
