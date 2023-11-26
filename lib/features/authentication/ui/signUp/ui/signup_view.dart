import 'package:flutter/material.dart';
import 'package:journal_app/features/authentication/ui/signUp/ui/signup_view_model.dart';
import 'package:stacked/stacked.dart';

// TODO: figure out why this wont build with build runner
// @RoutePage()
class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => SignUpViewModel(),
      builder: (context, viewModel, _) {
        return const SizedBox();
      },
    );
  }
}
