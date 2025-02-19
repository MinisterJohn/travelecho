import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

IconButton appBarIconButton(BuildContext context) {
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
      Navigator.pop(context);
    },
  );
}

AppBar setAppBar(String titleText, BuildContext context, {List<Widget> actions = const []}) {
  return AppBar(
    leading: appBarIconButton(context),
    centerTitle: true,
    title: Text(
      titleText,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        fontFamily: 'Segoe UI',
      ),
    ),
    actions:  actions
  );
}
