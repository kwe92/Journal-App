import 'package:diary_app/app/app_router.dart';
import 'package:diary_app/app/theme/theme.dart';
import 'package:diary_app/features/shared/services/get_it.dart';
import 'package:flutter/material.dart';

void main() {
  configureDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: AppTheme.getTheme(),
      routerConfig: appRouter.config(),
    );
  }
}
