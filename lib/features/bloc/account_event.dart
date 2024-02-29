part of 'account_bloc.dart';

@immutable
sealed class AccountEvent {}

class CreateAccountEvent extends AccountEvent {}
