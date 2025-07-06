import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../passport_exports.dart';

class AllTravelDocumentsPage extends StatefulWidget {
  const AllTravelDocumentsPage({super.key});

  @override
  State<AllTravelDocumentsPage> createState() => _AllTravelDocumentsPageState();
}

class _AllTravelDocumentsPageState extends State<AllTravelDocumentsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {}); // Rebuild when tab changes
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BlocBuilder<TravelDocumentBloc, TravelDocumentState>(
            builder: (context, state) {
              if (state is TravelDocumentLoaded) {
                final now = DateTime.now();
                final expiredTravelDocuments =
                    state.passports
                        .where(
                          (p) =>
                              p.expiryDate.isBefore(now) ||
                              p.expiryDate.isAtSameMomentAs(now),
                        )
                        .toList();
                final activeTravelDocuments =
                    state.passports
                        .where((p) => p.expiryDate.isAfter(now))
                        .toList();
                return AllTravelDocumentsTabs(
                  tabController: _tabController,
                  activeTravelDocuments: activeTravelDocuments,
                  expiredTravelDocuments: expiredTravelDocuments,
                );
              }
              if (state is TravelDocumentError) {
                return ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    SizedBox(height: 200),
                    Center(child: Text(state.message)),
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          ),
          BlocBuilder<TravelDocumentBloc, TravelDocumentState>(
            builder: (context, state) {
              if (state is TravelDocumentLoading) {
                return const TravelDocumentsLoadingOverlay();
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      floatingActionButton: const AddTravelDocumentFab(),
    );
  }
}
