import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:journal_app/app/app_router.gr.dart';
import 'package:journal_app/app/resources/reusables.dart';
import 'package:journal_app/app/theme/colors.dart';
import 'package:journal_app/features/authentication/ui/signUp/ui/signup_view_model.dart';
import 'package:journal_app/features/authentication/ui/signUp/ui/widgets/email_sign_up.dart';
import 'package:journal_app/features/shared/services/app_mode_service.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:journal_app/features/shared/ui/button/custom_back_button.dart';
import 'package:journal_app/features/shared/ui/button/selectable_button.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

@RoutePage()
class SignUpView extends StatelessWidget {
  SignUpView({super.key});

  final formKey = GlobalKey<FormState>();

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final FocusNode passwordFocus = FocusNode();
  final FocusNode confirmPasswordFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpViewModel>.reactive(
      viewModelBuilder: () => SignUpViewModel(),
      onViewModelReady: (SignUpViewModel model) async {
        model.initialize();
        // assign user email to emailController to be displayed on signup view
        emailController.text = model.email!;

        // add listener to passwordFocus watching for state changes and triggering associated callback
        passwordFocus.addListener(() {
          // if the password TextFormField has focus show the requirements popup
          model.setShowRequirements(passwordFocus.hasFocus);
        });
      },
      builder: (context, SignUpViewModel model, _) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: context.watch<AppModeService>().isLightMode ? Colors.white : AppColors.darkGrey1,
            body: SizedBox(
              width: double.maxFinite,
              height: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    children: [
                      Container(
                        width: double.maxFinite,
                        height: 210,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: model.mindfulImage!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 75,
                        height: 75,
                        child: CustomBackButton(
                          color: Colors.white,
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      )
                    ],
                  ),
                  gap12,
                  const Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Text(
                      "Sign-up",
                      style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
                    ),
                  ),
                  gap12,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 36.0),
                    child: Column(
                      children: [
                        Form(
                          key: formKey,
                          child: EmailSignUp(
                            emailController: emailController,
                            passwordController: passwordController,
                            confirmPasswordController: confirmPasswordController,
                            emailFocus: emailFocus,
                            passwordFocus: passwordFocus,
                            confirmPasswordFocus: confirmPasswordFocus,
                          ),
                        ),
                        gap36,
                        SelectableButton(
                          onPressed: () async {
                            if ((formKey.currentState?.validate() ?? false) && model.ready) {
                              model.unfocusAll(context);

                              // upon successful validation sign the user up.
                              final bool statusOk = await model.signupWithEmail(user: userService.tempUser!);

                              if (statusOk) {
                                // remove added listeners
                                passwordFocus.removeListener(() {
                                  model.setShowRequirements(passwordFocus.hasFocus);
                                });
                                // remove member info view and navigate to journal view
                                await appRouter.replace(NavigationRoute());
                              }
                            }
                          },
                          label: "Sign-up",
                        ),
                      ],
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
