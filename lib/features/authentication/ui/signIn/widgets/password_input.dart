import 'package:flutter/material.dart';
import 'package:journal_app/features/authentication/ui/signIn/signin_view_model.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:journal_app/features/shared/services/string_service.dart';
import 'package:stacked/stacked.dart';

class PasswordInput extends ViewModelWidget<SignInViewModel> {
  final FocusNode focus;
  final TextEditingController passwordController;
  final FocusNode? nextFocus;

  const PasswordInput({
    required this.passwordController,
    required this.focus,
    this.nextFocus,
    super.key,
  });

  @override
  Widget build(BuildContext context, SignInViewModel model) {
    return TextFormField(
      textInputAction: TextInputAction.done,
      controller: passwordController,
      focusNode: focus,
      autofillHints: const [AutofillHints.password],
      validator: stringService.customStringValidator(
        passwordController.text,
        configuration: const StringValidatorConfiguration(notEmpty: true),
      ),
      obscureText: model.obscurePassword,
      onChanged: model.setPassword,
      onEditingComplete: () => (nextFocus != null) ? nextFocus!.requestFocus() : focus.unfocus(),
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter Password",
        suffixIcon: IconButton(
          onPressed: () => model.setObscure(!model.obscurePassword),
          icon: Icon(model.obscurePassword ? Icons.visibility_off : Icons.visibility),
        ),
      ),
    );
  }
}
