import 'dart:async';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/services.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:journal_app/app/app_router.gr.dart';
import 'package:journal_app/app/theme/theme.dart';
import 'package:journal_app/features/journal/ui/journal_view_model.dart';
import 'package:journal_app/features/shared/services/get_it.dart';
import 'package:flutter/material.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:journal_app/features/shared/ui/button/expandingFab/controllers/expandable_fab_controller.dart';
import 'package:journal_app/features/shared/utilities/load_env_variables.dart';
import 'package:journal_app/features/shared/utilities/widget_keys.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // disable landscape mode
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // when using RiveFile.import then RiveFile.initialize() should be called manually.
  unawaited(RiveFile.initialize());

  await loadEnvVariables();

  // initalize and register all services.
  await configureDependencies();

  // required for late initialization of isLightMode
  await Future.delayed(const Duration(milliseconds: 100));

  // ensure token is removed from user device on app startup
  await tokenService.removeAccessTokenFromStorage();

  await notificationService.initializeNotificationChannels();

  await notificationService.checkNotificationPermissions();

  await databaseService.initialize();

  await journalEntryService.getAllEntries();

  notificationService.setNotificationListeners();

  appRouter.push(const NavigationRoute());

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
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider.value(
              value: appModeService,
            ),
            ChangeNotifierProvider(
              create: (context) => JournalViewModel(),
            ),
            ChangeNotifierProvider(
              create: (BuildContext context) => ExpandableFabController(initialOpen: false),
            )
          ],
          builder: (context, _) {
            return const MyApp();
          },
        ),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    deviceSizeService.setSmallDevice(_isSmallDevice(context));
    return MaterialApp.router(
      scaffoldMessengerKey: WidgetKey.rootScaffoldMessengerKey,
      theme: AppTheme.getTheme(context),
      routerConfig: appRouter.config(),
    );
  }
}

bool _isSmallDevice(BuildContext context) => MediaQuery.of(context).size.height < 700 ? true : false;
