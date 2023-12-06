import 'package:flutter/material.dart';
import 'package:journal_app/app/resources/reusables.dart';
import 'package:journal_app/features/authentication/ui/signUp/ui/signup_view_model.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:stacked/stacked.dart';

class EmailSignUp extends ViewModelWidget<SignUpViewModel> {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final FocusNode emailFocus;
  final FocusNode passwordFocus;
  final FocusNode confirmPasswordFocus;

  const EmailSignUp(
      {required this.emailController,
      required this.passwordController,
      required this.confirmPasswordController,
      required this.emailFocus,
      required this.passwordFocus,
      required this.confirmPasswordFocus,
      super.key});

  @override
  Widget build(BuildContext context, SignUpViewModel viewModel) {
    return Column(
      children: [
        TextFormField(
          // which one looks better enabled false or read-only true
          enabled: false,
          focusNode: emailFocus,
          textInputAction: TextInputAction.next,
          controller: emailController,
          validator: stringService.emailIsValid,
          autofillHints: const [AutofillHints.email],
          onChanged: viewModel.setEmail,
          onEditingComplete: () => passwordFocus.requestFocus(),
          decoration: const InputDecoration(
            labelText: 'Email Address',
            hintText: 'Enter Email Address',
          ),
        ),
        gap12,
        TextFormField(
          textInputAction: TextInputAction.next,
          controller: passwordController,
          focusNode: passwordFocus,
          autofillHints: const [AutofillHints.password],
          validator: stringService.passwordIsValid,
          obscureText: viewModel.obscurePassword,
          onChanged: viewModel.setPassword,
          onEditingComplete: () => confirmPasswordFocus.requestFocus(),
          decoration: InputDecoration(
            labelText: "Password",
            hintText: "Enter Password",
            suffixIcon: IconButton(
              onPressed: () => viewModel.setObscure(!viewModel.obscurePassword),
              icon: Icon(viewModel.obscurePassword ? Icons.visibility_off : Icons.visibility),
            ),
          ),
        ),
        gap12,
        TextFormField(
          textInputAction: TextInputAction.done,
          controller: confirmPasswordController,
          focusNode: confirmPasswordFocus,
          autofillHints: const [AutofillHints.password],
          validator: viewModel.confirmValidator,
          obscureText: viewModel.obscurePassword,
          onChanged: viewModel.setConfirmPassword,
          onEditingComplete: () => confirmPasswordFocus.unfocus(),
          decoration: InputDecoration(
            labelText: "Password",
            hintText: "Enter Password",
            suffixIcon: IconButton(
              onPressed: () => viewModel.setObscure(!viewModel.obscurePassword),
              icon: Icon(viewModel.obscurePassword ? Icons.visibility_off : Icons.visibility),
            ),
          ),
        ),
      ],
    );
  }
}
