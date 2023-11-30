import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:journal_app/features/authentication/ui/signIn/signin_view_model.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:journal_app/features/shared/ui/widgets/clear_icon.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

// TODO: add comments | StackedHookView | flutter hooks
// TODO: add leading icon to clear text

class EmailInput extends StackedHookView<SignInViewModel> {
  final FocusNode focus;
  final FocusNode? nextFocus;

  const EmailInput({
    required this.focus,
    this.nextFocus,
    super.key,
  });

  @override
  Widget builder(BuildContext context, SignInViewModel model) {
    // useTextEditingController: flutter hook that allows the use of TextEditingController's in a stateless widget
    final TextEditingController emailController = useTextEditingController();

    return TextFormField(
      // move to next focus node
      textInputAction: TextInputAction.next,
      controller: emailController,
      focusNode: focus,
      // commonly used hints
      autofillHints: const [AutofillHints.email],
      validator: stringService.emailIsValid,
      onChanged: model.setEmail,
      onEditingComplete: () => (nextFocus != null) ? nextFocus!.requestFocus() : focus.unfocus(),
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter Email Address",
        suffixIcon: emailController.text.isNotEmpty ? ConditionalClearIcon(controller: emailController) : null,
      ),
    );
  }
}

// StackedHookView

//   - returns a model in the builder function that was passed as a parameterized type
//   - allows the use of flutter hooks as well

// Flutter Hooks | package

//   - minimize the amount of bolierplate code that a stateful widget would require
//     to work with various controllers
//   - enables the use of controllers within a stateful widget
