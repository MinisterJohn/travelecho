import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../memories_exports.dart';

class UserHeader extends StatelessWidget {
  final String username;
  final String? location;
  final VoidCallback onView;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const UserHeader({
    super.key,
    required this.username,
    this.location,
    required this.onView,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundColor: AppColors.defaultColor100,
              child: const Icon(LineIcons.user),
            ),
            WidgetsSpacer.horinzontalSpacer8,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  username,
                  style: TextStyle(fontSize: 12),
                ),
                Text(
                  location ?? "",
                  style: TextStyle(color: AppColors.defaultColor400),
                )
              ],
            ),
          ],
        ),
        const Spacer(),
        IconButton(
          icon: Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.defaultColor400),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.more_horiz_outlined,
              color: AppColors.defaultColor400,
            ),
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return Center(
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 250),
                      margin: const EdgeInsets.symmetric(horizontal: 40),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildOptionButton(
                            context,
                            'View Memory',
                            LineIcons.eye,
                            onView,
                          ),
                          Divider(color: AppColors.defaultColor100),
                          _buildOptionButton(
                            context,
                            'Edit Memory',
                            LineIcons.editAlt,
                            onEdit,
                          ),
                          Divider(color: AppColors.defaultColor100),
                          _buildOptionButton(
                            context,
                            'Delete Memory',
                            LineIcons.alternateTrash,
                            onDelete,
                            isDelete: true,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildOptionButton(
    BuildContext context,
    String text,
    IconData icon,
    VoidCallback onTap, {
    bool isDelete = false,
  }) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon(
            //   icon,
            //   color: isDelete ? Colors.red : AppColors.defaultColor,
            //   size: 24,
            // ),
            // WidgetsSpacer.verticalSpacer8,
            Text(
              text,
              style: TextStyle(
                fontSize: 16,
                color: isDelete ? Colors.red : AppColors.defaultColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
