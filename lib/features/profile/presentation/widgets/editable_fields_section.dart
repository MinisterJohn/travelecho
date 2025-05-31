import 'package:flutter/material.dart' hide CarouselController;
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
    final profile = (state as ProfileLoaded).profile;
    // if (state is! ProfileLoaded) return const SizedBox.shrink();

    return Column(
      children: [
        _buildEditableField(
          icon: LineIcons.home,
          title: profile.location.isEmpty ? "Where I live" : profile.location,
          onTap: () {
            if (!isLocationLoading) showWhereILiveDialog(context);
          },
          isLoading: isLocationLoading,
        ),
        const Divider(color: AppColors.defaultColor100),
        _buildEditableField(
          icon: LineIcons.briefcase,
          title:
              profile.occupation.isEmpty ? "My occupation" : profile.occupation,
          onTap: () {
            if (!isOccupationLoading) showWhereIWorkDialog(context);
          },
          isLoading: isOccupationLoading,
        ),
        const Divider(color: AppColors.defaultColor100),
        _buildEditableField(
          icon: LineIcons.graduationCap,
          title: profile.school.name.isEmpty
              ? "Where I schooled"
              : "${profile.school.name} - ${profile.school.country}",
          onTap: () {
            if (!isSchoolLoading) showWhereISchooledDialog(context);
          },
          isLoading: isSchoolLoading,
        ),
        const Divider(color: AppColors.defaultColor100),
        _buildEditableField(
          icon: LineIcons.birthdayCake,
          title: profile.dateOfBirth != null &&
                  profile.dateOfBirth!.isBefore(DateTime.now()
                      .subtract(Duration(days: (5 * 365.25).round())))
              ? formatDate(profile.dateOfBirth as DateTime)
              : "Date of Birth",
          onTap: () {
            if (!isDobLoading) showDateDialog(context);
          },
          isLoading: isDobLoading,
        ),
        const Divider(color: AppColors.defaultColor100),
        _buildEditableField(
          icon: LineIcons.language,
          title: profile.languages.isEmpty
              ? "Language I speak"
              : profile.languages.map((lang) => lang).join(", "),
          onTap: () {
            if (!isLanguageLoading) showLanguageDialog(context);
          },
          isLoading: isLanguageLoading,
        ),
        const Divider(color: AppColors.defaultColor100),
        _buildEditableField(
          icon: LineIcons.shapes,
          title: profile.interests.isEmpty
              ? "Interests"
              : profile.interests.map((interest) => interest).join(", "),
          onTap: () {
            if (!isInterestsLoading) showInterestsDialog(context);
          },
          hasArrow: true,
          isLoading: isInterestsLoading,
        ),
      ],
    );
  }

  Widget _buildEditableField({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool hasArrow = false,
    bool isLoading = false,
  }) {
    return ListTile(
      leading: isLoading
          ? const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : Icon(icon, color: AppColors.defaultColor),
      title: Text(
        title,
        style: const TextStyle(color: AppColors.secondaryColor),
      ),
      trailing: hasArrow
          ? const Icon(Icons.chevron_right, color: AppColors.defaultColor400)
          : null,
      onTap: isLoading ? () {} : onTap,
    );
  }
}
