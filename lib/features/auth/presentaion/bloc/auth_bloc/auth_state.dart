part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

class Loading extends AuthState {}

class Failed extends AuthState {
  final String message;
  const Failed(this.message);
}

class CreateAccountSuccess extends AuthState {}

class SignInSuccess extends AuthState {}
