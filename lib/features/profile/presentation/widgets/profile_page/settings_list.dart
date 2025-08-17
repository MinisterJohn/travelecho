import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import 'package:travelecho/features/service_provider/presentation/service_provider_form.dart';
import '../../../profile_exports.dart';
import './settings_list_item.dart';

class SettingsList extends StatelessWidget {
  const SettingsList({super.key});

  Widget _buildDivider() {
    return const Divider(color: AppColors.defaultColor100);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "Settings",
            style: TextStyle(
              fontSize: FontSize.size16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        WidgetsSpacer.verticalSpacer16,
        SettingsListItem(
          icon: LineIcons.userCircle,
          title: "Personal Information",
          onTap: () {
            AppNavigator.push(
              context,
              MultiBlocProvider(
                providers: [
                  BlocProvider(create: (context) => sl<DataSearchBloc>()),
                  BlocProvider.value(value: sl<ProfileBloc>()),
                ],
                child: const EditPersonalInformation(),
              ),
            );
          },
        ),
        _buildDivider(),
        SettingsListItem(
          icon: LineIcons.passport,
          title: "Travel Documents",
          onTap: () {
            AppNavigator.push(
              context,
              BlocProvider.value(
                value: sl<TravelDocumentBloc>(),
                child: const TravelDocumentDetailsPage(),
              ),
            );
          },
        ),
        _buildDivider(),

        SettingsListItem(
          icon: LineIcons.trophy,
          title: "Milestones & Achievements",
          onTap: () {
            AppNavigator.push(
              context,
              BlocProvider.value(
                value: sl<LevelBloc>(),
                child: const MilestonesPage(),
              ),
            );
          },
        ),

        _buildDivider(),
        SettingsListItem(
          icon: LineIcons.car,
          title: "Become a Service Provider",
          onTap: () {
            AppNavigator.push(context, const ServiceProviderForm());
          },
        ),
        _buildDivider(),
        SettingsListItem(
          icon: LineIcons.cogs,
          title: "App and Features",
          onTap: () {
            AppNavigator.push(context, const FeaturesPage());
          },
        ),

        _buildDivider(),
        SettingsListItem(
          icon: LineIcons.questionCircle,
          title: "Help",
          onTap: () {
            AppNavigator.push(context, const HelpPage());
          },
        ),
        _buildDivider(),
        SettingsListItem(
          icon: LineIcons.infoCircle,
          title: "About",
          onTap: () {
            AppNavigator.push(context, const AboutPage());
          },
        ),
        _buildDivider(),
        SettingsListItem(
          icon: LineIcons.alternateShield,
          title: "Login and Security",
          onTap: () {
            AppNavigator.push(context, const LoginAndSecurityPage());
          },
        ),
        _buildDivider(),
      ],
    );
  }
}
