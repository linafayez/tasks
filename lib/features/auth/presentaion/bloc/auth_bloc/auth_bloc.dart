import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/params/create_account_prams.dart';
import '../../../domain/usecases/auth_usecases.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthUsecases _usecases;
  AuthBloc(this._usecases) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is CreateAccount) {
        emit(Loading());
        var response = await _usecases.createAccount(event.parameters);
        response.fold((l) => emit(Failed(l)), (r) => emit(CreateAccountSuccess()));
      } else if (event is SignIn) {
        emit(Loading());
        var response = await _usecases.signIn(event.parameters);
        response.fold((l) => emit(Failed(l)), (r) => emit(SignInSuccess()));
      }
    });
  }
}
