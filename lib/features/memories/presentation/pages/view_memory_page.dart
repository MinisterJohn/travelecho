import 'package:flutter/material.dart';
import "package:line_icons/line_icons.dart";
import 'package:readmore/readmore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import '../../memories_exports.dart';

class ViewMemoryPage extends StatefulWidget {
  final MemoryModel memory;

  const ViewMemoryPage({super.key, required this.memory});

  @override
  _ViewMemoryPageState createState() => _ViewMemoryPageState();
}

class _ViewMemoryPageState extends State<ViewMemoryPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {}); // Rebuild when tab changes
    });
    prefs = sl<SharedPreferences>();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadImage(String url) async {
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    final SharedPreferences prefs = sl<SharedPreferences>();
    final String? username = prefs.getString('name');
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: setAppBar('', context),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: UserHeader(
                  username: username ?? "User",
                  createdAt: widget.memory.createdAt,
                  location: widget.memory.location,

                  onEdit: () {
                    handleEditMemory(context, widget.memory);
                    // Handle edit profile action
                  },
                  onDelete: () {
                    handleDeleteMemory(context, widget.memory);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 50.0,
                ), // Adjust padding to avoid overlap
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      WidgetsSpacer.verticalSpacer16,
                      Text(
                        widget.memory.title,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      WidgetsSpacer.verticalSpacer8,
                      ReadMoreText(
                        widget.memory.description,
                        trimLines: 5,
                        colorClickableText: AppColors.primaryColor,
                        trimMode: TrimMode.Line,
                        trimCollapsedText: 'Read more',
                        trimExpandedText: 'Show less',
                        style: TextStyle(fontSize: FontSize.size18),
                      ),
                      WidgetsSpacer.verticalSpacer8,
                      if (widget.memory.tags.isNotEmpty)
                        Wrap(
                          spacing: 8.0,
                          children:
                              widget.memory.tags.map((tag) {
                                return Text(
                                  "#$tag",
                                  style: TextStyle(
                                    color: AppColors.primaryColor,
                                  ),
                                );
                              }).toList(),
                        ),
                      WidgetsSpacer.verticalSpacer32,

                      TabBar(
                        controller: _tabController,
                        isScrollable: false, // ⬅️ Allows custom tab width
                        indicatorColor: Colors.transparent,
                        dividerHeight: 0,
                        // indicatorSize: TabBarIndicatorSize.tab,
                        padding: EdgeInsets.zero,
                        tabs: [
                          _buildTab(0, LineIcons.image, 'Images'),
                          _buildTab(1, LineIcons.infoCircle, 'Details'),
                        ],
                      ),
                      WidgetsSpacer.verticalSpacer16,
                      IndexedStack(
                        index: _tabController.index,
                        children: [
                          _buildImagesTab(widget.memory),
                          _buildDetailsTab(widget.memory),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTab(int index, IconData icon, String label) {
    final bool isSelected = _tabController.index == index;

    return Tab(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.4, // ~40% of screen width
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border:
                isSelected
                    ? null
                    : Border.all(color: AppColors.defaultColor400),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isSelected ? Colors.white : Colors.black,
                size: 16,
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImagesTab(MemoryModel memory) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Memory Images", style: TextStyle(fontSize: 20)),
        WidgetsSpacer.verticalSpacer16,
        memory.images.isNotEmpty
            ? Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children:
                  memory.images.map((image) {
                    return FutureBuilder(
                      future: _loadImage(image["url"]),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Shimmer.fromColors(
                            baseColor: Colors.grey[500]!,
                            highlightColor: Colors.grey[300]!,
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return const Icon(Icons.error, color: Colors.red);
                        } else {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              image["url"],
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          );
                        }
                      },
                    );
                  }).toList(),
            )
            : const Center(child: Text('No images available')),
      ],
    );
  }

  Widget _buildDetailsTab(MemoryModel memory) {
    return DetailsTab(memory: memory);
  }
}
