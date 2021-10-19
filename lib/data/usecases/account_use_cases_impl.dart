import 'package:ancorio_rp/di/locator.dart';
import 'package:ancorio_rp/domain/repository/account_repository.dart';
import 'package:ancorio_rp/domain/usecases/account_use_cases.dart';

class AccountUseCasesImpl implements AccountUseCases {
  final AccountRepository _accountRepository = locator<AccountRepository>();

  @override
  Future<void> signInWithGoogle() async {
    await _accountRepository.signInWithGoogle();
  }
}
