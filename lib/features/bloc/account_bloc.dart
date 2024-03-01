import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:email/features/repos/check_account_repo.dart';
import 'package:email/features/repos/createAccount_repo.dart';
import 'package:meta/meta.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  bool _isPasswordVisible = false;
  AccountBloc() : super(AccountInitial()) {
    on<CreateAccountEvent>(_createAccountEvent);
    on<PasswordVisibilityChangeEvent>(_passwordVisibilityChangeEvent);
    on<CheckAccountEvent>(_checkAccountEvent);
  }

  FutureOr<void> _passwordVisibilityChangeEvent(
      PasswordVisibilityChangeEvent event, Emitter<AccountState> emit) {
    _isPasswordVisible = !_isPasswordVisible;
    emit(PasswordVisibilityChangeState(_isPasswordVisible));
  }
}

FutureOr<void> _createAccountEvent(
    CreateAccountEvent event, Emitter<AccountState> emit) async {
  bool success = await CreateAccountRepo.create(event.email, event.password);
  if (success == true) {
    emit(AccountCreateSuccessState(success: success));
  } else {
    emit(AccountCreateErrorState(success: success));
  }
}

FutureOr<void> _checkAccountEvent(
    CheckAccountEvent event, Emitter<AccountState> emit) async {
  String? token = await checkAccountRepo.check(event.email, event.password);
  if (token != null) {
    emit(AccountCheckSuccessState(token: token));
  } else {
    emit(AccountCheckErrorState());
  }
}
