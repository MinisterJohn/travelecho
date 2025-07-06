import 'package:flutter/material.dart';
import '../../passport_exports.dart';

class ViewTravelDocumentPage extends StatefulWidget {
  final TravelDocumentModel passport;
  const ViewTravelDocumentPage({super.key, required this.passport});

  @override
  State<ViewTravelDocumentPage> createState() => _ViewTravelDocumentPageState();
}

class _ViewTravelDocumentPageState extends State<ViewTravelDocumentPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final passport = widget.passport;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: setAppBar('TravelDocument Details', context),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TravelDocumentTabHeader(passport: passport),
              WidgetsSpacer.verticalSpacer16,
              TravelDocumentTabBar(controller: _tabController),
              WidgetsSpacer.verticalSpacer16,
              Expanded(
                child: IndexedStack(
                  index: _tabController.index,
                  children: [
                    TravelDocumentDetailsTab(passport: passport),
                    TravelDocumentImagesTab(images: passport.imageUrls),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
