import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../config/design_config/const_values.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({super.key, required this.body, this.bottomNavigationBar});
  final Widget body;
  final Widget? bottomNavigationBar;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: PADDING_SIZE.w, vertical: 5.h),
        child: body,
      )),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
