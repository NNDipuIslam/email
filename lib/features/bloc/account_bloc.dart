import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:email/features/repos/createAccount_repo.dart';
import 'package:meta/meta.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  bool _isPasswordVisible = false;
  AccountBloc() : super(AccountInitial()) {
    on<CreateAccountEvent>(_createAccountEvent);
    on<PasswordVisibilityChangeEvent>(_passwordVisibilityChangeEvent);
  }

  FutureOr<void> _passwordVisibilityChangeEvent(
      PasswordVisibilityChangeEvent event, Emitter<AccountState> emit) {
    _isPasswordVisible = !_isPasswordVisible;
    emit(PasswordVisibilityChangeState(_isPasswordVisible));
  }
}

FutureOr<void> _createAccountEvent(
    CreateAccountEvent event, Emitter<AccountState> emit) async {
  print(1);
  bool success = await CreateAccountRepo.create(event.email, event.password);
  // print(success);
  print(success);
  if (success == true) {
    emit(AccountCreateSuccessState(success: success));
    print(2);
  } else {
    //print(success);
    emit(AccountCreateErrorState(success: success));
  }
}
