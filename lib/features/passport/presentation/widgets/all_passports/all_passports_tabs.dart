import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import '../../../passport_exports.dart';

class AllTravelDocumentsTabs extends StatelessWidget {
  final TabController tabController;
  final List<TravelDocumentModel> activeTravelDocuments;
  final List<TravelDocumentModel> expiredTravelDocuments;

  const AllTravelDocumentsTabs({
    super.key,
    required this.tabController,
    required this.activeTravelDocuments,
    required this.expiredTravelDocuments,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TabBar(
          controller: tabController,
          indicatorColor: Colors.transparent,
          dividerHeight: 0,
          labelPadding: const EdgeInsets.symmetric(horizontal: 4),
          tabs: [
            TravelDocumentTab(
              controller: tabController,
              index: 0,
              icon: LineIcons.passport,
              label: 'Active Travel Documents',
            ),
            TravelDocumentTab(
              controller: tabController,
              index: 1,
              icon: LineIcons.timesCircle,
              label: 'Expired Travel Documents',
            ),
          ],
        ),
        WidgetsSpacer.verticalSpacer20,
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: [
              TravelDocumentList(
                passports: activeTravelDocuments,
                isExpired: false,
              ),
              TravelDocumentList(
                passports: expiredTravelDocuments,
                isExpired: true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
