import 'package:device_preview/device_preview.dart';
import 'package:flutter/services.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:journal_app/app/app_router.gr.dart';
import 'package:journal_app/app/theme/theme.dart';
import 'package:journal_app/features/shared/services/get_it.dart';
import 'package:flutter/material.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:journal_app/features/shared/utilities/widget_keys.dart';
import 'package:provider/provider.dart';

void main() async {
  // TODO: ensure that the AppModeService is being watched properly
  WidgetsFlutterBinding.ensureInitialized();

  // disable landscape mode
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // initalize and register all services.
  await configureDependencies();

  // required for late initialization of isLightMode
  await Future.delayed(const Duration(milliseconds: 100));

  // ensure token is removed from user device on app startup
  await tokenService.removeAccessTokenFromStorage();

  appRouter.push(SignInRoute());
  // appRouter.push(FarewellRoute());

  runApp(
    DevicePreview(
      enabled: false,
      tools: const [
        ...DevicePreview.defaultTools,
      ],
      builder: (context) =>
          // Portal Widget required at the root of the widget tree to use the PortalTarget Widget
          Portal(
        child: ChangeNotifierProvider.value(
          value: appModeService,
          builder: (context, _) => const MyApp(),
        ),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        scaffoldMessengerKey: WidgetKey.rootScaffoldMessengerKey,
        theme: AppTheme.getTheme(context),
        routerConfig: appRouter.config(),
      );
}
