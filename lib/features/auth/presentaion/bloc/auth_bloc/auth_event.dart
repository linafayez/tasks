part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class CreateAccount extends AuthEvent {
  AuthParameters parameters;
  CreateAccount(this.parameters);
}

class SignIn extends AuthEvent {
  AuthParameters parameters;
  SignIn(this.parameters);
}
