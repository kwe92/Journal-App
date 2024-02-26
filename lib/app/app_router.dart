import 'package:auto_route/auto_route.dart';
import 'app_router.gr.dart';

/// refresh generated router 'dart run build_runner build --delete-conflicting-outputs'
@AutoRouterConfig(replaceInRouteName: "Page|Screen|View,Route")

/// navigation for all available views
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        CustomRoute(
          initial: true,
          page: SignInRoute.page,
          transitionsBuilder: TransitionsBuilders.slideBottom,
        ),
        AutoRoute(page: SignUpRoute.page),
        AutoRoute(page: JournalRoute.page),
        AutoRoute(page: EntryRoute.page),
        AutoRoute(page: MemberInfoRoute.page),
        AutoRoute(page: AddEntryRoute.page),
        CustomRoute(
          page: MoodRoute.page,
          transitionsBuilder: TransitionsBuilders.slideBottom,
        ),
        AutoRoute(page: ProfileSettingsRoute.page),
        AutoRoute(page: EditProfileRoute.page),
        AutoRoute(page: FarewellRoute.page),
        AutoRoute(page: CalendarRoute.page),
        CustomRoute(
          page: NavigationRoute.page,
          transitionsBuilder: TransitionsBuilders.slideBottom,
        ),
        AutoRoute(page: RandomQuotesRoute.page),
        AutoRoute(page: LikedQuotesRoute.page),
      ];
}
