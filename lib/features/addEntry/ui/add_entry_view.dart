import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:journal_app/app/app_router.gr.dart';
import 'package:journal_app/app/theme/theme.dart';
import 'package:journal_app/features/addEntry/ui/add_entry_view_model.dart';
import 'package:journal_app/features/shared/models/new_entry.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:journal_app/features/shared/services/string_service.dart';
import 'package:journal_app/features/shared/ui/base_scaffold.dart';
import 'package:journal_app/features/shared/ui/button/custom_back_button.dart';
import 'package:journal_app/features/shared/ui/button/selectable_button.dart';
import 'package:journal_app/features/shared/ui/widgets/form_container.dart';
import 'package:stacked/stacked.dart';

@RoutePage()
class AddEntryView extends StatelessWidget {
  final String moodType;

  const AddEntryView({required this.moodType, super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController newEntryController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return ViewModelBuilder.reactive(
      viewModelBuilder: () => AddEntryViewModel(),
      builder: (context, model, _) => BaseScaffold(
        // title: "Add Entry",

        // Manifested in french
        title: "Manifesté",
        leading: CustomBackButton(
          onPressed: () => appRouter.pop(),
        ),
        body: Column(
          children: [
            FormContainer(
              child: Form(
                key: formKey,
                child: TextFormField(
                  // focus text field upon inital render
                  autofocus: true,
                  expands: true,
                  maxLines: null,
                  // automatically capitalize sentences for user
                  textCapitalization: TextCapitalization.sentences,
                  controller: newEntryController,
                  decoration: borderlessInput.copyWith(hintText: "What's on your mind...?"),
                  onChanged: (value) => model.setContent(value),
                  validator: stringService.customStringValidator(
                    newEntryController.text,
                    configuration: const StringValidatorConfiguration(notEmpty: true),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: SelectableButton(
                  onPressed: () async {
                    if ((formKey.currentState?.validate() ?? false) && model.ready) {
                      final bool ok = await model.addEntry(
                        NewEntry(moodType: moodType, content: model.content!.trim()),
                      );

                      if (ok) {
                        appRouter.replace(JournalRoute());
                      }
                    }
                  },
                  label: "Add Entry"),
            ),
          ],
        ),
      ),
    );
  }
}

// Infinitly Long TextField

//   - set TextField parameters:
//       ~ expands: true
//       ~ maxLines: null