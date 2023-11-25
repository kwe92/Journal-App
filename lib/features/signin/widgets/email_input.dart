import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:journal_app/features/signin/signin_view_model.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

// TODO: add comments | StackedHookView | flutter hooks

class EmailInput extends StackedHookView<SignInViewModel> {
  final FocusNode focus;
  final FocusNode? nextFocus;

  const EmailInput({required this.focus, this.nextFocus, super.key});

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
      validator: (String? value) {
        // TODO: replace with string service and a call to string validator
      },
      onChanged: model.setEmail,
      onEditingComplete: () => (nextFocus != null) ? nextFocus!.requestFocus() : focus.unfocus(),
      decoration: const InputDecoration(
        labelText: "Email",
        hintText: "Enter Email Address",
      ),
    );
  }
}
