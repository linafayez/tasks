import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../config/app_localization.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({super.key, required this.controller, required this.labelText, this.obscureText, this.validator, this.onTap, this.maxLines = 1});
  final TextEditingController? controller;
  final String? labelText;
  final bool? obscureText;
  final String? Function(String? value)? validator;
  final void Function()? onTap;
  final int? maxLines;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: TextFormField(
        maxLines: maxLines,
        validator: validator,
        obscureText: obscureText ?? false,
        controller: controller,
        keyboardType: onTap != null ? TextInputType.none : null,
        onTap: onTap,
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
            labelText: AppLocalization.of(context).getTranslatedValues(labelText ?? "")),
      ),
    );
  }
}
