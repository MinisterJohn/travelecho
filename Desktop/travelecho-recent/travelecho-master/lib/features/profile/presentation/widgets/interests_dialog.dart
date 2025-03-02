import 'package:flutter/material.dart';
import 'package:travelecho/features/profile/presentation/blocs/profile_bloc.dart';
import 'package:travelecho/features/profile/presentation/widgets/bottomModalDraggable.dart';
import 'package:travelecho/features/profile/presentation/pages/saveinterest.dart';
import 'package:travelecho/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelecho/features/profile/presentation/blocs/data_search_bloc.dart';

void showInterestsDialog(BuildContext context) {
  DraggableBottomModal(
      context,
      MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: sl<DataSearchBloc>(),
          ),
          BlocProvider.value(
            value: sl<ProfileBloc>(),
          ),
        ],
        child: const InterestSelectionPage(),
      ));
}
