import 'package:dartz/dartz.dart';

import '../params/create_account_prams.dart';

abstract class IAuthRepository {
  Future<Either<String, String>> createAccount(AuthParameters parameters);
  Future<Either<String, String>> signIn(AuthParameters parameters);
}
