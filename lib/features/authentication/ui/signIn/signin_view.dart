import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:journal_app/app/app_router.gr.dart';
import 'package:journal_app/app/resources/reusables.dart';
import 'package:journal_app/features/authentication/ui/signIn/signin_view_model.dart';
import 'package:journal_app/features/authentication/ui/signIn/widgets/email_input.dart';
import 'package:journal_app/features/authentication/ui/signIn/widgets/password_input.dart';
import 'package:journal_app/features/authentication/ui/signIn/widgets/remember_me_section.dart';
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
    final smallDevice = deviceSizeService.smallDevice;

    return ViewModelBuilder<SignInViewModel>.reactive(
      createNewViewModelOnInsert: true,
      viewModelBuilder: () => SignInViewModel(),
      onViewModelReady: (SignInViewModel model) async => await model.initialize(context),
      builder: (context, SignInViewModel model, _) {
        return model.isLoading!
            ? Scaffold(
                body: Center(
                  child: Container(
                    // TODO: temp key for testing | remove later
                    key: const GlobalObjectKey('find-widget'),

                    height: MediaQuery.of(context).size.height / 7.875,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: Image.asset(
                          'assets/images/splash_screen.png',
                        ).image,
                      ),
                    ),
                  ),
                ),
              )
            : SafeArea(
                child: Scaffold(
                  backgroundColor: Theme.of(context).colorScheme.background,
                  body: SizedBox(
                    width: double.maxFinite,
                    height: double.maxFinite,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: double.maxFinite,
                          height: MediaQuery.of(context).size.height / (!smallDevice ? 3.125 : 3.5),
                          child: Image(
                            image: model.mindfulImage!,
                            fit: BoxFit.cover,
                          ),
                        ),
                        !smallDevice ? gap24 : gap12,
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            "Log-in",
                            style: TextStyle(
                              fontSize: !smallDevice ? 32 : 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        !smallDevice ? gap24 : const SizedBox(),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Form(
                              key: formKey,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    EmailInput(
                                      emailController: model.emailController,
                                      focus: emailFocus,
                                      nextFocus: passwordFocus,
                                    ),
                                    !smallDevice ? gap16 : gap4,
                                    PasswordInput(
                                      passwordController: model.passwordController,
                                      focus: passwordFocus,
                                    ),
                                    !smallDevice ? gap12 : gap4,
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const RememberMeSection(),
                                        TextButton(
                                          onPressed: () {},
                                          child: const Text(
                                            "Forgot password?",
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                      ],
                                    ),
                                    !smallDevice ? gap16 : gap4,
                                    SelectableButton(
                                      onPressed: () async {
                                        // focus email TextFormField if it is empty
                                        model.email == null || model.email!.isEmpty ? emailFocus.requestFocus() : null;

                                        if ((formKey.currentState?.validate() ?? false) && model.ready) {
                                          model.unfocusAll(context);

                                          // check successful login
                                          final bool statusOk = await model.signInWithEmail();

                                          // if successful, login
                                          if (statusOk) {
                                            await model.handleEmailAndPasswordStorage();
                                            model.emailController.clear();
                                            model.passwordController.clear();
                                            await appRouter.push(NavigationRoute());
                                          }
                                        }
                                      },
                                      label: "Login",
                                    ),
                                    !smallDevice ? gap16 : gap4,
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          "Don't have an account?",
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        TextButton(
                                          onPressed: () async => await appRouter.push(MemberInfoRoute()),
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


// Transform Widget | Geometrical Transfomations

//   - 2-D (R2 Space) Translations (Positional Slides on X or Y axis) and Dilations (Scaling)


// ImageProvider

//   - to use Image.asset within DecorationImage retrieve
//     - ImageProvider from image property
//       e.g. Image.asset('assets/imeage/path').image