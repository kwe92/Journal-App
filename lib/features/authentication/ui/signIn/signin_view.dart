import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:journal_app/app/app_router.gr.dart';
import 'package:journal_app/app/resources/reusables.dart';
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

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => SignInViewModel(),
      onViewModelReady: (model) => model.initialize(),
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
                      model.mindfulImage!,
                      fit: BoxFit.cover,
                    ),
                  ),
                  gap24,
                  const Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Text(
                      "Log-in",
                      style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
                    ),
                  ),
                  gap12,
                  Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 36.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          EmailInput(
                            emailController: emailController,
                            focus: emailFocus,
                            nextFocus: passwordFocus,
                          ),
                          gap16,
                          PasswordInput(
                            passwordController: passwordController,
                            focus: passwordFocus,
                          ),
                          gap12,
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Forgot password?",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          gap16,
                          SelectableButton(
                              onPressed: () async {
                                model.email == null || model.email!.isEmpty ? emailFocus.requestFocus() : null;
                                if ((formKey.currentState?.validate() ?? false) && model.ready) {
                                  model.unfocusAll(context);

                                  final bool ok = await model.signInWithEmail(context);

                                  if (ok) {
                                    emailController.clear();
                                    passwordController.clear();
                                    appRouter.push(const JournalRoute());
                                  }
                                }
                              },
                              label: "Login"),
                          gap16,
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
