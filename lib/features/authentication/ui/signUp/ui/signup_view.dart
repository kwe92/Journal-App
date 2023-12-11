import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:journal_app/app/app_router.gr.dart';
import 'package:journal_app/app/resources/reusables.dart';
import 'package:journal_app/features/authentication/models/user.dart';
import 'package:journal_app/features/authentication/ui/signUp/ui/signup_view_model.dart';
import 'package:journal_app/features/authentication/ui/signUp/ui/widgets/email_sign_up.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:journal_app/features/shared/ui/button/custom_back_button.dart';
import 'package:journal_app/features/shared/ui/button/selectable_button.dart';
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

  final image = imageService.getRandomMindfulImage();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => SignUpViewModel(),
      onViewModelReady: (model) {
        model.initialize();
        // assign user email to emailController to be displayed on signup view
        emailController.text = model.email!;

        // add listener to passwordFocus watching for state chages and triggering associated callback
        passwordFocus.addListener(() {
          model.setShowRequirements(passwordFocus.hasFocus);
        });
      },
      builder: (context, model, _) {
        return SafeArea(
            child: Scaffold(
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
                          image: AssetImage(image),
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
                            final bool ok = await model.signupWithEmail(user: userService.tempUser as User);

                            if (ok) {
                              // remove member info view and navigate to journal view | there maybe a better way to refresh widget
                              appRouter.replace(JournalRoute());
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
        ));
      },
    );
  }
}
