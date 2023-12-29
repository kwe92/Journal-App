import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:journal_app/app/app_router.gr.dart';
import 'package:journal_app/app/theme/theme.dart';
import 'package:journal_app/features/addEntry/ui/add_entry_view_model.dart';
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

    return ViewModelBuilder<AddEntryViewModel>.reactive(
      viewModelBuilder: () => AddEntryViewModel(),
      onViewModelReady: (AddEntryViewModel model) => model.initialize(moodType),
      builder: (BuildContext context, AddEntryViewModel model, _) => BaseScaffold(
        moodColor: model.moodColor,
        // Manifested in french
        title: "Manifesté",
        leading: CustomBackButton(
          color: model.moodColor,
          onPressed: () => appRouter.pop(),
        ),
        body: Column(
          children: [
            FormContainer(
              dayOfWeekByName: model.dayOfWeekByName,
              timeOfDay: model.timeOfDay,
              continentalTime: model.continentalTime,
              child: Form(
                key: formKey,
                child: Theme(
                  data: Theme.of(context).copyWith(
                    textSelectionTheme: AppTheme.getTextSelectionThemeData(model.moodColor!),
                    cupertinoOverrideTheme: AppTheme.getCupertinoOverrideTheme(model.moodColor!),
                  ),
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
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: SelectableButton(
                  color: model.moodColor,
                  onPressed: () async {
                    if ((formKey.currentState?.validate() ?? false) && model.ready) {
                      final bool statusOk = await model.addEntry(
                        moodType,
                        model.content!,
                      );

                      if (statusOk) {
                        appRouter.replace(const JournalRoute());
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