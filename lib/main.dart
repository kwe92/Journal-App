import 'package:flutter/services.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:journal_app/app/app_router.gr.dart';
import 'package:journal_app/app/theme/theme.dart';
import 'package:journal_app/features/shared/services/get_it.dart';
import 'package:flutter/material.dart';
import 'package:journal_app/features/shared/services/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // disable landscape mode
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // initalize and register all services.
  await configureDependencies();

  // ensure token is removed from user device on app startup
  await tokenService.removeAccessTokenFromStorage();

  appRouter.push(SignInRoute());

  runApp(
    // Portal Widget required at the root of the widget tree to use the PortalTarget Widget
    const Portal(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        theme: AppTheme.getTheme(),
        routerConfig: appRouter.config(),
      );
}
