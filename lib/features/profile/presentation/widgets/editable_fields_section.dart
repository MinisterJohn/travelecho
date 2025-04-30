import 'package:flutter/material.dart';
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
    // if (state is! ProfileLoaded) return const SizedBox.shrink();

    return Column(
      children: [
        _buildEditableField(
          icon: LineIcons.home,
          title: state.profile.location.isEmpty
              ? "Where I live"
              : state.profile.location,
          onTap: () {
            if (!isLocationLoading) showWhereILiveDialog(context);
          },
          isLoading: isLocationLoading,
        ),
        Divider(color: AppColors.defaultColor100),
        _buildEditableField(
          icon: LineIcons.briefcase,
          title: state.profile.occupation.isEmpty
              ? "My occupation"
              : state.profile.occupation,
          onTap: () {
            if (!isOccupationLoading) showWhereIWorkDialog(context);
          },
          isLoading: isOccupationLoading,
        ),
        Divider(color: AppColors.defaultColor100),
        _buildEditableField(
          icon: LineIcons.graduationCap,
          title: state.profile.school.name.isEmpty
              ? "Where I schooled"
              : "${state.profile.school.name} - ${state.profile.school.country}",
          onTap: () {
            if (!isSchoolLoading) showWhereISchooledDialog(context);
          },
          isLoading: isSchoolLoading,
        ),
        Divider(color: AppColors.defaultColor100),
        _buildEditableField(
          icon: LineIcons.birthdayCake,
          title: state.profile.dob.isBefore(
                  DateTime.now().subtract(Duration(days: (5 * 365.25).round())))
              ? formatDate(state.profile.dob)
              : "Date of Birth",
          onTap: () {
            if (!isDobLoading) showDateDialog(context);
          },
          isLoading: isDobLoading,
        ),
        Divider(color: AppColors.defaultColor100),
        _buildEditableField(
          icon: LineIcons.language,
          title: state.profile.languages.isEmpty
              ? "Language I speak"
              : state.profile.languages.map((lang) => lang).join(", "),
          onTap: () {
            if (!isLanguageLoading) showLanguageDialog(context);
          },
          isLoading: isLanguageLoading,
        ),
        Divider(color: AppColors.defaultColor100),
        _buildEditableField(
          icon: LineIcons.shapes,
          title: state.profile.interests.isEmpty
              ? "Interests"
              : state.profile.interests.map((interest) => interest).join(", "),
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
          ? Icon(Icons.chevron_right, color: AppColors.defaultColor400)
          : null,
      onTap: isLoading ? () {} : onTap,
    );
  }
}
