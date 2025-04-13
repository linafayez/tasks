import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tasks_joddb/core/config/injection_container.dart';

import 'package:tasks_joddb/features/auth/data/params/create_account_prams.dart';

import '../../data/datasource/auth_datasource.dart';
import '../../data/repositories/auth_repository.dart';

class AuthRepository implements IAuthRepository {
  IAuthDatasource datasource;
  AuthRepository(this.datasource);
  @override
  Future<Either<String, String>> createAccount(AuthParameters parameters) async {
    try {
      var response = await datasource.createAccount(parameters);
      if (response.user != null) {
        sharedPrefsClient.email = parameters.email;

        return const Right("common_success");
      } else {
        return const Left("common_error");
      }
    } on FirebaseAuthException catch (e) {
      return Left(e.code);
    } catch (_) {
      return const Left("common_error");
    }
  }

  @override
  Future<Either<String, String>> signIn(AuthParameters parameters) async {
    try {
      var response = await datasource.signIn(parameters);
      if (response.user != null) {
        sharedPrefsClient.email = parameters.email;
        return const Right("common_success");
      } else {
        return const Left("common_error");
      }
    } on FirebaseAuthException catch (e) {
      return Left(e.code);
    } catch (_) {
      return const Left("common_error");
    }
  }
}
