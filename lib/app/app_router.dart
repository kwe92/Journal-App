import 'package:auto_route/auto_route.dart';
import 'app_router.gr.dart';

/// refresh generated router 'dart run build_runner build --delete-conflicting-outputs'
@AutoRouterConfig(replaceInRouteName: "Page|Screen|View,Route")

/// navigation for all available views
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SignInRoute.page, initial: true),
        AutoRoute(page: SignUpRoute.page),
        AutoRoute(page: JournalRoute.page),
        AutoRoute(page: EntryRoute.page),
        AutoRoute(page: MemberInfoRoute.page),
        AutoRoute(page: AddEntryRoute.page),
        AutoRoute(page: MoodRoute.page),
        AutoRoute(page: ProfileSettingsRoute.page),
        AutoRoute(page: EditProfileRoute.page),
        AutoRoute(page: FarewellRoute.page),
        AutoRoute(page: CalendarRoute.page),
        AutoRoute(page: ScaffoldWithNavigationRoute.page),
      ];
}
