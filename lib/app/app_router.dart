import 'package:auto_route/auto_route.dart';
import 'package:journal_app/features/shared/services/get_it.dart';
import 'app_router.gr.dart';

AppRouter get appRouter => locator.get<AppRouter>();

/// refresh generated router 'dart run build_runner build'

@AutoRouterConfig(replaceInRouteName: "Page|Screen|View,Route")
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: JournalRoute.page, initial: true),
        AutoRoute(page: EntryRoute.page),
      ];
}
