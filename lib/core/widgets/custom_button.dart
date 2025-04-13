import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasks_joddb/core/config/app_localization.dart';
import 'package:tasks_joddb/core/widgets/custom_text.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.onPressed, this.child, this.label});
  final void Function()? onPressed;
  final Widget? child;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.h),
      child: FilledButton(
          style: ButtonStyle(
              padding: WidgetStateProperty.all(EdgeInsets.all(15.w)),
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: BorderSide.none,
                ),
              )),
          onPressed: onPressed,
          child: label != null
              ? CustomText(AppLocalization.of(context).getTranslatedValues(label ?? ""),
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.white))
              : child != null
                  ? child
                  : CircularProgressIndicator(
                      color: Colors.white,
                    )),
    );
  }
}
