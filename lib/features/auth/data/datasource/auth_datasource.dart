import 'package:firebase_auth/firebase_auth.dart';

import '../params/create_account_prams.dart';

abstract class IAuthDatasource {
  Future<UserCredential> createAccount(AuthParameters parameters);
  Future<UserCredential> signIn(AuthParameters parameters);
}

class AuthDatasource implements IAuthDatasource {
  final FirebaseAuth firebaseAuth;
  const AuthDatasource(this.firebaseAuth);
  @override
  Future<UserCredential> createAccount(AuthParameters parameters) async {
    return await firebaseAuth.createUserWithEmailAndPassword(email: parameters.email, password: parameters.password);
  }

  @override
  Future<UserCredential> signIn(AuthParameters parameters) async {
    return await firebaseAuth.signInWithEmailAndPassword(email: parameters.email, password: parameters.password);
  }
}
