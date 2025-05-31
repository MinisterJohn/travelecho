import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../profile_exports.dart';

void showInterestsDialog(BuildContext context) {
  showDraggableBottomModal(
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
