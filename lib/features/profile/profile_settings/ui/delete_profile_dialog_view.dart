import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:journal_app/app/resources/reusables.dart';
import 'package:journal_app/app/theme/colors.dart';
import 'package:journal_app/app/theme/theme.dart';
import 'package:journal_app/features/profile/profile_settings/ui/delete_profile_dialog_view_model.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:journal_app/features/shared/ui/button/selectable_button.dart';
import 'package:journal_app/features/shared/utilities/popup_parameters.dart';
import 'package:stacked/stacked.dart';

class DeleteProfileDialogView extends StatelessWidget {
  final PopupMenuParameters parameters;
  const DeleteProfileDialogView({required this.parameters, super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => DeleteProfileDialogViewModel(),
      builder: (BuildContext context, DeleteProfileDialogViewModel model, _) {
        const style00 = TextStyle(fontSize: 12);

        return SimpleDialog(
          titlePadding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 0.0),
          contentPadding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 16.0),
          title: Text(
            parameters.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              foreground: Paint()..color = AppColors.blueGrey0,
            ),
          ),
          children: [
            if (parameters.content != null) ...[
              Text(
                parameters.content!,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14),
              ),
              gap16,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'type ',
                    style: style00,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    decoration: BoxDecoration(
                      color: AppColors.offGrey.withOpacity(0.15),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(4),
                      ),
                    ),
                    child: Text(
                      model.userEmail,
                      style: style00.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Text(
                    ' to proceed',
                    style: style00,
                  ),
                ],
              ),
              gap16,
              Form(
                key: model.formKey,
                child: Theme(
                  data: Theme.of(context).copyWith(
                    inputDecorationTheme: deleteAccoutInputTheme,
                    textSelectionTheme: deleteAccoutTextSelectionTheme,
                  ),
                  child: TextFormField(
                    controller: model.confirmedEmailController,
                    autofillHints: const [AutofillHints.email],
                    validator: model.confirmValidAndMatchingEmail,
                    onChanged: model.setConfirmedEmail,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      hintText: 'Confirm Email',
                    ),
                  ),
                ),
              ),
              gap16,
            ],
            Column(
              children: [
                ...parameters.options.entries.mapIndexed((int index, MapEntry buttonOption) {
                  return index < parameters.options.entries.length - 1
                      ? Column(
                          children: [
                            SelectableButton(
                              color: model.emailMatch ? AppColors.lightGreen : AppColors.offGrey,
                              onPressed: () {
                                if (model.formKey.currentState!.validate()) {
                                  appRouter.pop(buttonOption.value);
                                }
                              },
                              label: buttonOption.key,
                            ),
                            gap12,
                          ],
                        )
                      : SelectableButton(
                          onPressed: () => appRouter.pop(buttonOption.value),
                          label: buttonOption.key,
                        );
                }).toList()
              ],
            )
          ],
        );
      },
    );
  }
}
