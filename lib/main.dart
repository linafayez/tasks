import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/config/app_localization.dart';
import 'core/navigation/custom_navigation.dart';
import 'features/auth/presentaion/screens/splash_screen.dart';
import 'firebase_options.dart';

import 'core/config/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  DependencyInjectionInit().registerSingletons();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return setupDependencies(
      child: ScreenUtilInit(
          splitScreenMode: true,
          designSize: const Size(414, 896),
          builder: (context, widget) {
            return MaterialApp(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                textTheme: TextTheme(labelLarge: TextStyle(fontSize: 19.sp)),
                useMaterial3: true,
              ),
              onGenerateRoute: CustomNavigator.onCreateRoute,
              navigatorKey: CustomNavigator.navigatorState,
              locale: const Locale('en', 'US'),
              supportedLocales: const [Locale('ar', 'JO'), Locale('en', 'US')],
              localizationsDelegates: const [
                AppLocalization.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              home: SplashScreen(),
            );
          }),
    );
  }
}
