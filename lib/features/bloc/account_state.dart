part of 'account_bloc.dart';

@immutable
sealed class AccountState {}

final class AccountInitial extends AccountState {}

class AccountActionState extends AccountState {}

class AccountCreateSuccessState extends AccountState {}

class AccountCreateErrorState extends AccountState {}
