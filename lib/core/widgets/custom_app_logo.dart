import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../config/enums/size_enum.dart';

class CustomAppLogo extends StatelessWidget {
  const CustomAppLogo({super.key, this.size = SizeEnum.medium});
  final SizeEnum size;

  double getSize() {
    switch (size) {
      case SizeEnum.large:
        return 0.4.sh;
      case SizeEnum.medium:
        return 0.35.sh;

      case SizeEnum.small:
        return 0.25.sh;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        "assets/images/logo.png",
        height: getSize(),
        width: getSize(),
      ),
    );
  }
}
