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
    final String? username = prefs.getString('name');

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: setAppBar('', context),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              /// User header pinned at top
              UserHeader(
                username: username ?? "User",
                createdAt: widget.memory.createdAt,
                location: widget.memory.location,
                onEdit: () => handleEditMemory(context, widget.memory),
                onDelete: () => handleDeleteMemory(context, widget.memory),
              ),
              WidgetsSpacer.verticalSpacer16,
              Expanded(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Memory title
                      Text(
                        widget.memory.title,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      WidgetsSpacer.verticalSpacer8,

                      /// Description with ReadMore
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

                      /// Tags
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
                      WidgetsSpacer.verticalSpacer16,

                      /// TabBar
                      TabBar(
                        controller: _tabController,
                        indicatorColor: Colors.transparent,
                        dividerHeight: 0,
                        labelPadding: const EdgeInsets.symmetric(horizontal: 4),
                        tabs: [
                          _buildTab(0, LineIcons.image, 'Images'),
                          _buildTab(1, LineIcons.infoCircle, 'Details'),
                        ],
                      ),
                      WidgetsSpacer.verticalSpacer16,

                      /// TabBarView fills remaining space
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            SingleChildScrollView(
                              child: _buildImagesTab(widget.memory),
                            ),
                            SingleChildScrollView(
                              child: _buildDetailsTab(widget.memory),
                            ),
                          ],
                        ),
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

  /// Build custom tab
  Widget _buildTab(int index, IconData icon, String label) {
    final bool isSelected = _tabController.index == index;

    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primaryColor : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border:
            isSelected ? null : Border.all(color: AppColors.defaultColor400),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: isSelected ? Colors.white : Colors.black, size: 16),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(color: isSelected ? Colors.white : Colors.black),
          ),
        ],
      ),
    );
  }

  /// Images tab
  Widget _buildImagesTab(MemoryModel memory) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Memory Images", style: TextStyle(fontSize: 20)),
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
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (_) => FullscreenImageViewer(
                                        images:
                                            memory.images
                                                .map((e) => e["url"])
                                                .toList(),
                                        initialIndex: memory.images.indexOf(
                                          image,
                                        ),
                                      ),
                                ),
                              );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                image["url"],
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
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

  /// Details tab
  Widget _buildDetailsTab(MemoryModel memory) {
    return DetailsTab(memory: memory);
  }
}
