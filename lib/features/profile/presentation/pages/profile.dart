import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "../../profile_exports.dart";
import '../widgets/profile_page/index.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final SharedPreferences _prefs = sl<SharedPreferences>();

  @override
  Widget build(BuildContext context) {
    final fullname = _prefs.getString('name');
    final email = _prefs.getString('email') ?? "";
    final isProUser = _prefs.getString('plan') ?? "";

    return Scaffold(
      // appBar: setAppBar("", context),
      body: Stack(
        children: [
          RefreshIndicator(
            onRefresh: () async {
              context.read<ProfileBloc>().add(ProfileLoadRequested());
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: BlocProvider.value(
                value: sl<AuthBloc>(),
                child: BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, authState) {
                    if (authState is AuthSuccess ||
                        authState is AuthLoginSuccess) {
                      return BlocProvider.value(
                        value: sl<ProfileBloc>()..add(ProfileLoadRequested()),
                        child: BlocBuilder<ProfileBloc, ProfileState>(
                          builder: (context, profileState) {
                            return Column(
                              children: [
                                ScreenContainer(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      BlocProvider.value(
                                        value: sl<ProfileBloc>(),
                                        child: ProfileHeader(
                                          fullname: fullname,
                                          email: email,
                                          isProUser: isProUser,
                                          profileState: profileState,
                                        ),
                                      ),
                                      const SizedBox(height: 32),
                                      BlocProvider.value(
                                        value: sl<LevelBloc>(),
                                        child: const SettingsList(),
                                      ),
                                      BlocProvider.value(
                                        value: sl<AuthBloc>(),
                                        child: LogoutButton(email: email),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      );
                    } else {
                      return const Center(
                        child: Text("Authentication required."),
                      );
                    }
                  },
                ),
              ),
            ),
          ),
          BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, profileState) {
              if (profileState is ProfileLoading) {
                return const ProfileLoadingIndicator();
              }
              return const SizedBox.shrink();
            },
          ),
          BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, profileState) {
              if (profileState is ProfileFailure) {
                return const ProfileErrorIndicator();
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
