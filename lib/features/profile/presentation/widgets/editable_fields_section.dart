import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import '../../profile_exports.dart';

class EditableFieldsSection extends StatelessWidget {
  final ProfileState state;
  final bool isLocationLoading;
  final bool isOccupationLoading;
  final bool isSchoolLoading;
  final bool isDobLoading;
  final bool isLanguageLoading;
  final bool isInterestsLoading;

  const EditableFieldsSection({
    super.key,
    required this.state,
    required this.isLocationLoading,
    required this.isOccupationLoading,
    required this.isSchoolLoading,
    required this.isDobLoading,
    required this.isLanguageLoading,
    required this.isInterestsLoading,
  });

  @override
  Widget build(BuildContext context) {
    // if (state is! ProfileLoaded) {
    //   return const SizedBox.shrink(); // Return an empty widget for non-ProfileLoaded states
    // }

    // final profile = (state as ProfileLoaded).profile;

    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        print("EditableFieldsSection: Rebuilding with state: $state");
        // if (state is ProfileLoading || state is ProfileUpdating) {
        //   return const Center(child: CircularProgressIndicator());
        // }
        // if (state is! ProfileLoaded) {
        //   return const SizedBox.shrink(); // Return an empty widget for non-ProfileLoaded states
        // }

        final profile = (state is ProfileLoaded) ? state.profile : null;

        return Column(
          children: [
            _buildEditableField(
              icon: LineIcons.home,
              title:
                  profile?.location.isEmpty ?? true
                      ? "Where I live"
                      : profile!.location,
              onTap: () {
                if (!isLocationLoading) showWhereILiveDialog(context);
              },
              isLoading: isLocationLoading || state is ProfileLoading,
            ),
            const Divider(color: AppColors.defaultColor100),
            _buildEditableField(
              icon: LineIcons.briefcase,
              title:
                  profile?.occupation.isEmpty ?? true
                      ? "My occupation"
                      : profile!.occupation,
              onTap: () {
                if (!isOccupationLoading) showWhereIWorkDialog(context);
              },
              isLoading: isOccupationLoading || state is ProfileLoading,
            ),
            const Divider(color: AppColors.defaultColor100),
            _buildEditableField(
              icon: LineIcons.graduationCap,
              title:
                  profile?.school.name.isEmpty ?? true
                      ? "Where I schooled"
                      : profile!.school.name,
              onTap: () {
                if (!isSchoolLoading) showWhereISchooledDialog(context);
              },
              isLoading: isSchoolLoading || state is ProfileLoading,
            ),
            const Divider(color: AppColors.defaultColor100),
            _buildEditableField(
              icon: LineIcons.birthdayCake,
              title:
                  (profile?.dateOfBirth != null &&
                          profile!.dateOfBirth!.isBefore(
                            DateTime.now().subtract(
                              Duration(days: (5 * 365.25).round()),
                            ),
                          ))
                      ? formatDate(profile.dateOfBirth!)
                      : "Date of Birth",
              onTap: () {
                if (!isDobLoading) showDateDialog(context);
              },
              isLoading: isDobLoading || state is ProfileLoading,
            ),
            const Divider(color: AppColors.defaultColor100),
            _buildEditableField(
              icon: LineIcons.language,
              title:
                  profile?.languages.isEmpty ?? true
                      ? "Language I speak"
                      : profile!.languages.map((lang) => lang).join(", "),
              onTap: () {
                if (!isLanguageLoading) showLanguageDialog(context);
              },
              isLoading: isLanguageLoading || state is ProfileLoading,
            ),
            const Divider(color: AppColors.defaultColor100),
            _buildEditableField(
              icon: LineIcons.shapes,
              title:
                  profile?.interests.isEmpty ?? true
                      ? "Interests"
                      : profile!.interests
                          .map((interest) => interest)
                          .join(", "),
              onTap: () {
                if (!isInterestsLoading) showInterestsDialog(context);
              },
              hasArrow: true,
              isLoading: isInterestsLoading || state is ProfileLoading,
            ),
          ],
        );
      },
    );
  }

  Widget _buildEditableField({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool hasArrow = false,
    bool isLoading = false,
  }) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: sl<ProfileBloc>()),
        BlocProvider.value(value: sl<DataSearchBloc>()),
      ],
      child: ListTile(
        leading: Icon(icon, color: AppColors.defaultColor),

        title: Text(
          title,
          style: const TextStyle(color: AppColors.secondaryColor),
        ),
        trailing:
            isLoading
                ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
                : hasArrow
                ? const Icon(
                  Icons.chevron_right,
                  color: AppColors.defaultColor400,
                )
                : null,
        onTap: isLoading ? () {} : onTap,
      ),
    );
  }
}
