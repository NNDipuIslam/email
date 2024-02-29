import 'package:bloc/bloc.dart';
import 'package:email/features/repos/createAccount_repo.dart';
import 'package:meta/meta.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc() : super(AccountInitial()) {
    on<CreateAccountEvent>(_createAccountEvent);
  }
}

void _createAccountEvent(
    CreateAccountEvent event, Emitter<AccountState> emit) async {
  print(1);
  bool success = await CreateAccountRepo.create("dipu@yogirt.com", "hi123");
  print(success);
  if (success == true) {
    emit(AccountCreateSuccessState());
  } else {
    emit(AccountCreateErrorState());
  }
}
