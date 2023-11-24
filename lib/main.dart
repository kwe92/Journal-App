import 'package:journal_app/app/theme/theme.dart';
import 'package:journal_app/features/shared/services/get_it.dart';
import 'package:flutter/material.dart';
import 'package:journal_app/features/shared/services/services.dart';

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
