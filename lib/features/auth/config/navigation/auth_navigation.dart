import 'package:flutter/material.dart';
import 'package:tasks_joddb/features/auth/presentaion/screens/sign_up_screen.dart';
import '../../presentaion/screens/sign_in_screen.dart';
import '../navigation/auth_routes.dart';

abstract class AuthNavigator {
  static Route? serviceRoute(RouteSettings settings) {
    switch (settings.name) {
      case AuthRoutes.SIGN_IN_SCREEN:
        return MaterialPageRoute(builder: (context) => SignInScreen());
      case AuthRoutes.SIGN_UP_SCREEN:
        return MaterialPageRoute(builder: (context) => SignUpScreen());

      default:
    }
    return null;
  }
}
