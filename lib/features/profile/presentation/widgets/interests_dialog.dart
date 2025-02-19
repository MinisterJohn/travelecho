import 'package:flutter/material.dart';
import 'package:travelecho/core/hoc/bottomModalDraggable.dart';
import 'package:travelecho/features/profile/presentation/pages/saveinterest.dart';

void showInterestsDialog(BuildContext context) {
  DraggableBottomModal(context, InterestSelectionPage());
}
