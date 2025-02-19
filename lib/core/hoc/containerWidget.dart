import 'package:flutter/widgets.dart';
import "package:flutter_screenutil/flutter_screenutil.dart";

class ScreenContainer extends StatefulWidget {
  final Widget child;
  const ScreenContainer({super.key, required this.child});
  @override
  State<ScreenContainer> createState() => _ScreenContainerState();
}

class _ScreenContainerState extends State<ScreenContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 375.w,
      margin: EdgeInsets.only(top: 10.h),
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: widget.child,
    );
  }
}
