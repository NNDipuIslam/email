// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'account_bloc.dart';

@immutable
sealed class AccountState {}

final class AccountInitial extends AccountState {}

class AccountActionState extends AccountState {}

class AccountCreateSuccessState extends AccountState {
  bool success;
  AccountCreateSuccessState({
    required this.success,
  });
}

class AccountCreateErrorState extends AccountState {
  bool success;
  AccountCreateErrorState({
    required this.success,
  });
}

class AccountCheckSuccessState extends AccountState {}

class AccountCheckErrorState extends AccountState {}

class PasswordVisibilityChangeState extends AccountState {
  final bool isPasswordVisible;

  PasswordVisibilityChangeState(this.isPasswordVisible);
}
