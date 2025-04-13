import 'package:flutter/material.dart';
import 'package:tasks_joddb/core/config/enums/size_enum.dart';
import 'package:tasks_joddb/core/config/injection_container.dart';
import 'package:tasks_joddb/core/navigation/custom_navigation.dart';
import 'package:tasks_joddb/core/widgets/custom_app_logo.dart';
import 'package:tasks_joddb/features/auth/config/navigation/auth_routes.dart';
import 'package:tasks_joddb/features/main/config/navigation/main_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      CustomNavigator.push(sharedPrefsClient.email.isEmpty ? AuthRoutes.SIGN_IN_SCREEN : MainRoutes.MAIN_SCREEN, clean: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomAppLogo(
          size: SizeEnum.large,
        ),
      ),
    );
  }
}
