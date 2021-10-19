import 'package:ancorio_rp/data/repository/account_repository_impl.dart';
import 'package:ancorio_rp/data/usecases/account_use_cases_impl.dart';
import 'package:ancorio_rp/domain/repository/account_repository.dart';
import 'package:ancorio_rp/domain/usecases/account_use_cases.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setupLocatorRepositories() {
  locator.registerLazySingleton<AccountRepository>(() {
    return AccountRepositoryImpl();
  });
}

void setupLocatorUseCases() {
  locator.registerLazySingleton<AccountUseCases>(() {
    return AccountUseCasesImpl();
  });
}
