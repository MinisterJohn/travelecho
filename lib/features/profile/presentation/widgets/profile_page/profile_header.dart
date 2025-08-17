import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../profile_exports.dart';

class ProfileHeader extends StatelessWidget {
  final String? fullname;
  final String email;
  final String isProUser;
  final ProfileState profileState;

  const ProfileHeader({
    super.key,
    required this.fullname,
    required this.email,
    required this.isProUser,
    required this.profileState,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return Column(
          children: [
            WidgetsSpacer.verticalSpacer16,
            Row(
              // mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Profile",
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: FontSize.size28,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                (isProUser.isNotEmpty && isProUser == "FREE")
                    ? ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(0, 0),
                        shape: const StadiumBorder(),
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                      ),
                      onPressed: () {
                        upgradeToPro(context);
                      },
                      icon: Icon(Icons.diamond_outlined),
                      label: Text(
                        "Upgrade to Pro",
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: FontSize.size14,
                        ),
                      ),
                    )
                    : Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 16.0,
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.diamond_outlined,
                            color: AppColors.primaryColor,
                            size: 20,
                          ),
                          // WidgetsSpacer.horizontalSpacer8,
                          // Text(
                          //   "Verified pro user",
                          //   style: TextStyle(
                          //     color: AppColors.primaryColor,
                          //     fontSize: FontSize.size16,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
              ],
            ),
            WidgetsSpacer.verticalSpacer16,
            Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[300],
                    image:
                        state is ProfileLoaded && state.profile.image.isNotEmpty
                            ? DecorationImage(
                              image: NetworkImage(state.profile.image),
                              fit: BoxFit.cover,
                              alignment: Alignment.topCenter,
                            )
                            : null,
                  ),
                ),

                WidgetsSpacer.horizontalSpacer16,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        fullname ??
                            (state is ProfileLoaded
                                ? state.profile.userId
                                : 'User'),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        email,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 94, 97, 99),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
