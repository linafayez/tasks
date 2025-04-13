import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({super.key, this.child, this.color});
  final Widget? child;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      elevation: 15,
      child: Padding(
        padding: EdgeInsets.all(15.w),
        child: child,
      ),
    );
  }
}
