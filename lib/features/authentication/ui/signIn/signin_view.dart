import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:journal_app/app/app_router.gr.dart';
import 'package:journal_app/features/authentication/ui/signIn/signin_view_model.dart';
import 'package:journal_app/features/authentication/ui/signIn/widgets/email_input.dart';
import 'package:journal_app/features/authentication/ui/signIn/widgets/password_input.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:journal_app/features/shared/ui/button/selectable_button.dart';
import 'package:stacked/stacked.dart';

@RoutePage()
class SignInView extends StatelessWidget {
  SignInView({super.key});

  // used to locate form in widget tree and validate text form fields before processing them further
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => SignInViewModel(),
      builder: (context, model, _) {
        return SafeArea(
          child: Scaffold(
            body: SizedBox(
              width: double.maxFinite,
              height: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 3.125,
                    width: double.maxFinite,
                    child: Image.asset(
                      // TODO: replace with imageService and random image
                      "assets/images/mindful04.avif",
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Text(
                      "Log-in",
                      style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 36.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          EmailInput(focus: emailFocus, nextFocus: passwordFocus),
                          const SizedBox(height: 16),
                          PasswordInput(focus: passwordFocus),
                          const SizedBox(height: 12),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Forgot password?",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          const SizedBox(height: 16),
                          SelectableButton(
                              onPressed: () async {
                                model.email == null || model.email!.isEmpty ? emailFocus.requestFocus() : null;
                                toastService.unfocusAll(context);
                                if ((formKey.currentState?.validate() ?? false) && model.ready) {
                                  await model.signInWithEmail(context);
                                  if (authService.isLoggedIn) {
                                    appRouter.push(const JournalRoute());
                                  } else {
                                    // TODO: add a better error message
                                    toastService.showSnackBar();
                                  }
                                }
                              },
                              label: "Login"),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Don't have an account?",
                                style: TextStyle(fontSize: 14),
                              ),
                              TextButton(
                                onPressed: () => appRouter.push(MemberInfoRoute()),
                                child: const Text(
                                  "Sign-up",
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
