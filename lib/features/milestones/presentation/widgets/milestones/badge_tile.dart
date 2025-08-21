import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../milestones_exports.dart';

class BadgeTile extends StatelessWidget {
  final BadgeEntity badge;
  final bool isLast;

  const BadgeTile({super.key, required this.badge, required this.isLast});

  @override
  Widget build(BuildContext context) {
    final badgeImageUrl = badgeAssetPath(badge);

    return GestureDetector(
      onTap: () {
        if (isLast) {
          // ✅ Navigate only if it's the last earned badge
          AppNavigator.push(
            context,
            BlocProvider.value(
              value: sl<LevelBloc>(),
              child: MilestonePage(badgeImageUrl: badgeImageUrl, badge: badge),
            ),
          );
        } else {
          // ✅ Show badge details in a bottom sheet
          showModalBottomSheet(
            context: context,
            isScrollControlled: true, // ✅ allows full-width + taller content
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder:
                (context) => FractionallySizedBox(
                  widthFactor: 1, // ✅ full width
                  child: BadgeDetailsSheet(
                    badge: badge,
                    imageUrl: badgeImageUrl,
                  ),
                ),
          );
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(badgeImageUrl, width: 120.h, height: 120.h),
          WidgetsSpacer.verticalSpacer8,
          Row(
            spacing: 2,
            children: [
              Text(
                badge.name,
                style: TextStyle(
                  fontSize: FontSize.size16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              isLast
                  ? Icon(
                    Icons.fiber_new_outlined,
                    color: AppColors.primaryColor,
                  )
                  : Container(),
            ],
          ),
          Text(
            "Level ${badge.level}",
            style: TextStyle(
              fontSize: FontSize.size14,
              color: AppColors.defaultColor400,
            ),
          ),
        ],
      ),
    );
  }
}
