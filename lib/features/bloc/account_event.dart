// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'account_bloc.dart';

@immutable
sealed class AccountEvent {}

class PasswordVisibilityChangeEvent extends AccountEvent {}

class CreateAccountEvent extends AccountEvent {
  final String email;
  final String password;
  CreateAccountEvent({
    required this.email,
    required this.password,
  });
}

class CheckAccountEvent extends AccountEvent {
  String email;
  String password;
  CheckAccountEvent({
    required this.email,
    required this.password,
  });
}
