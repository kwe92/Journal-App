import "package:auto_route/annotations.dart";
import "package:journal_app/app/app_router.gr.dart";
import "package:journal_app/app/resources/reusables.dart";
import "package:journal_app/app/theme/theme.dart";
import "package:journal_app/features/entry/models/updated_entry.dart";
import "package:journal_app/features/entry/ui/entry_view_model.dart";
import 'package:journal_app/features/shared/models/journal_entry.dart';
import "package:journal_app/features/shared/services/services.dart";
import "package:journal_app/features/shared/services/string_service.dart";
import "package:journal_app/features/shared/ui/base_scaffold.dart";
import "package:flutter/material.dart";
import "package:journal_app/features/shared/ui/button/custom_back_button.dart";
import "package:journal_app/features/shared/ui/button/selectable_button.dart";
import 'package:journal_app/features/shared/ui/widgets/form_container.dart';
import "package:stacked/stacked.dart";

@RoutePage()
class EntryView extends StatelessWidget {
  final JournalEntry entry;

  const EntryView({required this.entry, super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => EntryviewModel(),
      onViewModelReady: (model) {
        model.initialize(entry);
      },
      builder: (context, model, _) {
        return BaseScaffold(
          moodColor: model.moodColor,
          title: entry.dateString,
          leading: CustomBackButton(
            color: model.moodColor,
            onPressed: () {
              model.setReadOnly(true);
              appRouter.replace(const JournalRoute());
            },
          ),
          body: Column(
            children: [
              FormContainer(
                entry: entry,
                height: MediaQuery.of(context).size.height / 1.65,
                child: Form(
                  child: TextFormField(
                    controller: model.entryController,
                    focusNode: model.entryFocus,
                    expands: true,
                    maxLines: null,
                    readOnly: model.readOnly,
                    textCapitalization: TextCapitalization.sentences,
                    validator: stringService.customStringValidator(
                      model.entryController.text,
                      configuration: const StringValidatorConfiguration(notEmpty: true),
                    ),
                    decoration: borderlessInput.copyWith(hintText: "What's on your mind...?"),
                    onChanged: (value) => model.setContent(value),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: SelectableButton(
                  color: model.moodColor,
                  onPressed: () async {
                    if (model.readOnly) {
                      model.setReadOnly(false);
                      model.entryFocus.requestFocus();
                    } else {
                      // push update to backend

                      final bool ok = await model.updateEntry(
                        UpdatedEntry(entryId: entry.entryId, content: model.content),
                      );

                      if (ok) {
                        appRouter.replace(const JournalRoute());
                      }

                      debugPrint("update entry");
                    }
                  },
                  label: model.readOnly ? "Edit Entry" : "Update Entry",
                ),
              ),
              gap16,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: SelectableButton(
                  color: model.moodColor,
                  onPressed: () async {
                    final bool deleteContinued = await model.continueDelete(context, model.moodColor!);

                    debugPrint('Should delete entry: $deleteContinued');

                    if (deleteContinued) {
                      final bool ok = await model.deleteEntry(entry.entryId);

                      if (ok) {
                        appRouter.replace(const JournalRoute());
                      }
                    }
                  },
                  label: "Delete Entry",
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
