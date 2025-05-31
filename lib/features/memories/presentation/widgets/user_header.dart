import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';

import '../../memories_exports.dart';

class UserHeader extends StatelessWidget {
  final String username;
  final String? location;
  final DateTime createdAt;
  final VoidCallback onView;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const UserHeader({
    super.key,
    required this.username,
    required this.createdAt,
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            BlocProvider.value(
              value: sl<ProfileBloc>(),
              child: BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, profileState) {
                  return profileState is ProfileLoaded
                      ? Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey[300],
                            image: DecorationImage(
                              image: NetworkImage(profileState.profile.image),
                              fit: BoxFit.cover,
                              alignment: Alignment.topCenter,
                            ),
                          ),
                        )
                      : const CircleAvatar(
                          radius: 20,
                          // backgroundColor: AppColors.primaryColor,
                          child: Icon(
                            Icons.person_outline_outlined,
                            size: 20,
                            color: Colors.white,
                          ),
                        );
                },
              ),
            ),
            WidgetsSpacer.horizontalSpacer8,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  username,
                  style: const TextStyle(fontSize: 14),
                ),
                Text(
                  "Posted: ${formatDate(createdAt)}",
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
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
            child: const Icon(
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
                          const Divider(color: AppColors.defaultColor100),
                          _buildOptionButton(
                            context,
                            'Edit Memory',
                            LineIcons.editAlt,
                            onEdit,
                          ),
                          const Divider(color: AppColors.defaultColor100),
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
