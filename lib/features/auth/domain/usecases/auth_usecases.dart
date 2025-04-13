import 'package:dartz/dartz.dart';

import '../../data/params/create_account_prams.dart';
import '../../data/repositories/auth_repository.dart';

class AuthUsecases {
  final IAuthRepository _repository;
  AuthUsecases(this._repository);
  Future<Either<String, String>> createAccount(AuthParameters parameters) async {
    return await _repository.createAccount(parameters);
  }

  Future<Either<String, String>> signIn(AuthParameters parameters) async {
    return await _repository.signIn(parameters);
  }
}
