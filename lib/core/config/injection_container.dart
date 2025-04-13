import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasks_joddb/features/main/config/tasks_injection.dart';

import '../../features/auth/config/auth_injection.dart';
import '../bloc_config/bloc_providers.dart';
import 'shared_prefs_client.dart';

final GetIt getIt = GetIt.instance;
final SharedPrefsClient sharedPrefsClient = getIt();

Widget setupDependencies({required Widget child}) => listOfBlocProviders(child);
Widget setupDependenciesMainScreen({required Widget child}) => listOfBlocProvidersForMainScreen(child);

class DependencyInjectionInit {
  static final DependencyInjectionInit _singleton = DependencyInjectionInit._();

  factory DependencyInjectionInit() => _singleton;

  DependencyInjectionInit._();

  /// Register the Basic Singleton
  Future<void> registerSingletons() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final sharedPrefsClient = SharedPrefsClient(sharedPreferences);
    getIt.registerLazySingleton(() => sharedPreferences);
    getIt.registerLazySingleton(() => sharedPrefsClient);
    AuthDependencyInjectionInit().registerSingletons();

    await TasksDependencyInjectionInit().registerSingletons();
  }
}
