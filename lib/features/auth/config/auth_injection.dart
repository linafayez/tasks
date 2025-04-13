import 'package:firebase_auth/firebase_auth.dart';
import 'package:tasks_joddb/core/config/injection_container.dart';
import 'package:tasks_joddb/features/auth/data/datasource/auth_datasource.dart';
import 'package:tasks_joddb/features/auth/domain/repositories/auth_repository.dart';

import '../data/repositories/auth_repository.dart';
import '../domain/usecases/auth_usecases.dart';

class AuthDependencyInjectionInit {
  static final AuthDependencyInjectionInit _singleton = AuthDependencyInjectionInit._();

  factory AuthDependencyInjectionInit() => _singleton;

  AuthDependencyInjectionInit._();

  /// Register the Basic Singleton
  void registerSingletons() {
    print("AuthDependencyInjectionInit");
    final auth = authUsecases();

    getIt.registerLazySingleton(() => auth);
    print(getIt.call<AuthUsecases>());
  }

  AuthUsecases authUsecases() {
    IAuthDatasource datasource = AuthDatasource(FirebaseAuth.instance);
    IAuthRepository repository = AuthRepository(datasource);
    return AuthUsecases(repository);
  }
}
