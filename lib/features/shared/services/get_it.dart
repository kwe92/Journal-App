import 'package:journal_app/app/app_router.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void configureDependencies() {
  locator.registerSingleton<AppRouter>(AppRouter());
}
