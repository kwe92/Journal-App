import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:journal_app/features/signin/signin_view_model.dart';
import 'package:journal_app/features/signin/widgets/email_input.dart';
import 'package:journal_app/features/signin/widgets/password_input.dart';
import 'package:stacked/stacked.dart';

// TODO: add comments to section off part of the UI

@RoutePage()
class SignInView extends StatelessWidget {
  SignInView({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => SignInViewModel(),
      builder: (context, viewModel, _) {
        return SafeArea(
          child: Scaffold(
            body: SizedBox(
              width: double.maxFinite,
              height: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset('assets/images/journal_photo.avif'),
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
                          SizedBox(
                            width: double.maxFinite,
                            // TODO: Add InkWell
                            child: OutlinedButton(
                              onPressed: () {
                                // TODO: add login invocation
                                viewModel.email == null || viewModel.email!.isEmpty ? emailFocus.requestFocus() : null;
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 12.0),
                                child: Text(
                                  "Login",
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Don't have an account?",
                                style: TextStyle(fontSize: 14),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: const Text(
                                  "Sign-up",
                                  style: TextStyle(fontSize: 14),
                                ),
                              )
                            ],
                          )

                          // View Model Email and Password state
                          // Column(
                          //   children: [
                          //     Text("${viewModel.email}"),
                          //     const SizedBox(height: 6),
                          //     Text("${viewModel.password}"),
                          //   ],
                          // )
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
