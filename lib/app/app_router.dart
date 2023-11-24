import 'package:auto_route/auto_route.dart';
import 'app_router.gr.dart';

/// refresh generated router 'dart run build_runner build'

@AutoRouterConfig(replaceInRouteName: "Page|Screen|View,Route")
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: JournalRoute.page, initial: true),
        AutoRoute(page: EntryRoute.page),
      ];
}
