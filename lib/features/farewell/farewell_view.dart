import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:journal_app/app/app_router.gr.dart';
import 'package:journal_app/features/shared/services/services.dart';

@RoutePage()
class FarewellView extends StatelessWidget {
  const FarewellView({super.key});

  @override
  Widget build(BuildContext context) {
    // anonymous function to replace the FarewellView with the SignInView after some delay
    () async {
      await Future.delayed(const Duration(seconds: 3));
      appRouter.replace(SignInRoute());
    }();

    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.maxFinite,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: Image.asset(
                'assets/images/fare-well-image.png',
                fit: BoxFit.cover,
              ).image,
            ),
          ),
        ),
      ),
    );
  }
}
