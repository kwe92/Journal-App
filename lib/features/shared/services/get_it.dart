import 'package:diary_app/app/app_router.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.I;

void configureDependencies() {
  getIt.registerSingleton<AppRouter>(AppRouter());
}
