import 'package:flutter/material.dart';
import 'package:tasks_joddb/core/config/app_localization.dart';

class CustomText extends StatelessWidget {
  const CustomText(this.text, {super.key, this.padding, this.style});
  final String text;
  final EdgeInsetsGeometry? padding;
  final TextStyle? style;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Text(
        AppLocalization.of(context).getTranslatedValues(text),
        style: style,
      ),
    );
  }
}
