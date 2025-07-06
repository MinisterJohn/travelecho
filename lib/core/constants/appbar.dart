import 'package:flutter/material.dart' hide CarouselController;
import 'package:line_icons/line_icons.dart';
import "../../features/features_exports.dart";

IconButton appBarIconButton(
  BuildContext context,
  VoidCallback? backAction,
) {
  return IconButton(
    icon: Container(
      padding: const EdgeInsets.all(4), // Padding inside the circle
      decoration: const BoxDecoration(
        color: Color.fromRGBO(248, 239, 255, 1),
        shape: BoxShape.circle,
      ),
      child: const Icon(
        LineIcons.arrowLeft,
        color: Colors.black,
        size: 25, // Adjusted icon size for better fit
      ),
    ),
    onPressed: () {
      if (Navigator.canPop(context)) {
        if (backAction != null) {
          backAction;
        } else {
          AppNavigator.pop(context);
        }
      } else {
        // If we can't pop, go to the root page
        AppNavigator.pushAndRemove(context, const RootPage());
      }
    },
  );
}

AppBar setAppBar(
  String titleText,
  BuildContext context, {
  List<Widget> actions = const [],
  VoidCallback? backAction,
}) {
  return AppBar(
    leading: appBarIconButton(context, backAction),
    centerTitle: true,
    title: Text(
      titleText,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        fontFamily: 'Segoe UI',
      ),
    ),
    actions: actions,
  );
}
