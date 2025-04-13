import 'package:flutter/material.dart';
import 'package:tasks_joddb/features/auth/presentaion/screens/splash_screen.dart';
import 'package:tasks_joddb/features/main/config/navigation/main_routes.dart';
import 'package:tasks_joddb/features/main/presentaion/screens/main_screen.dart';

import '../../features/auth/config/navigation/auth_navigation.dart';
import '../config/injection_container.dart';

/// Global Context of App
BuildContext? get currentContext => CustomNavigator.navigatorState.currentContext;

abstract class CustomNavigator {
  static int selectedTab = 0;
  static final GlobalKey<NavigatorState> navigatorState = GlobalKey<NavigatorState>();

  static List<GlobalKey<NavigatorState>> navigatorKeysBottomNav = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];
  static final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

  static Route<dynamic> onCreateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainRoutes.MAIN_SCREEN:
        return MaterialPageRoute(builder: (context) => setupDependenciesMainScreen(child: MainScreen()));
      case '/':
        return MaterialPageRoute(builder: (context) => SplashScreen());

      default:
        final auth = AuthNavigator.serviceRoute(settings);

        if (auth != null) {
          return auth;
        }
        return MaterialPageRoute(builder: (context) => Container());
    }
  }

  static Future pushInSubNavigator(
    String routeName, {
    arguments,
    bool replace = false,
    bool clean = false,
    bool rootNavigator = false,
    bool Function(Route<dynamic>)? predicate,
  }) {
    BuildContext context = navigatorKeysBottomNav[selectedTab].currentState?.context ?? currentContext!;

    if (clean) {
      return Navigator.of(context, rootNavigator: rootNavigator).pushNamedAndRemoveUntil(
        routeName,
        predicate ?? (_) => false,
        arguments: arguments,
      );
    } else if (replace) {
      return Navigator.of(context, rootNavigator: rootNavigator).pushReplacementNamed(routeName, arguments: arguments);
    } else {
      return Navigator.of(context, rootNavigator: rootNavigator).pushNamed(routeName, arguments: arguments);
    }
  }

  static push(
    String routeName, {
    arguments,
    bool replace = false,
    bool clean = false,
    bool Function(Route<dynamic>)? predicate,
  }) {
    if (navigatorState.currentState != null) {
      if (clean) {
        return navigatorState.currentState!.pushNamedAndRemoveUntil(
          routeName,
          predicate ?? (_) => false,
          arguments: arguments,
        );
      } else if (replace) {
        return navigatorState.currentState!.pushReplacementNamed(routeName, arguments: arguments);
      } else {
        return navigatorState.currentState!.pushNamed(routeName, arguments: arguments);
      }
    }
  }

  static void pop({dynamic result}) {
    if (navigatorState.currentState!.canPop()) {
      navigatorState.currentState!.pop(result);
    }
  }

  static void popInSubNavigator({dynamic result, bool Function(Route<dynamic>)? predicate}) {
    if (navigatorKeysBottomNav[selectedTab].currentState?.canPop() ?? false) {
      predicate != null
          ? navigatorKeysBottomNav[selectedTab].currentState!.popUntil(predicate)
          : navigatorKeysBottomNav[selectedTab].currentState!.pop(result);
    }
  }
}
