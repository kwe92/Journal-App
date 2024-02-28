import "package:auto_route/annotations.dart";
import "package:journal_app/app/app_router.gr.dart";
import "package:journal_app/app/resources/reusables.dart";
import "package:journal_app/app/theme/theme.dart";
import "package:journal_app/features/entry/ui/entry_view_model.dart";
import 'package:journal_app/features/shared/models/journal_entry.dart';
import "package:journal_app/features/shared/services/services.dart";
import "package:journal_app/features/shared/services/string_service.dart";
import "package:journal_app/features/shared/ui/base_scaffold.dart";
import "package:flutter/material.dart";
import "package:journal_app/features/shared/ui/button/custom_back_button.dart";
import "package:journal_app/features/shared/ui/button/selectable_button.dart";
import 'package:journal_app/features/shared/ui/widgets/form_container.dart';
import "package:journal_app/features/shared/ui/widgets/profile_icon.dart";
import "package:stacked/stacked.dart";

@RoutePage()
class EntryView extends StatelessWidget {
  final JournalEntry entry;

  const EntryView({required this.entry, super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EntryviewModel>.reactive(
      viewModelBuilder: () => EntryviewModel(entry: entry),
      onViewModelReady: (EntryviewModel model) {
        model.initialize();
      },
      builder: (context, EntryviewModel model, _) {
        return BaseScaffold(
          moodColor: model.moodColor,
          // title: entry.dateString,
          title: "Manifesté",
          leading: CustomBackButton(
            color: model.moodColor,
            onPressed: () {
              model.setReadOnly(true);
              appRouter.pop();
            },
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: ProfileIcon(
                userFirstName: model.currentUser?.firstName ?? "P",
                color: model.moodColor,
                onPressed: () async => await appRouter.push(const ProfileSettingsRoute()),
              ),
            ),
          ],
          body: SingleChildScrollView(
            child: Column(
              children: [
                FormContainer(
                  dayOfWeekByName: model.dayOfWeekByName,
                  timeOfDay: model.timeOfDay,
                  continentalTime: model.continentalTime,
                  height: MediaQuery.of(context).size.height / (!deviceSizeService.smallDevice ? 1.65 : 1.875),
                  child: Form(
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        textSelectionTheme: AppTheme.getTextSelectionThemeData(model.moodColor!),
                        cupertinoOverrideTheme: AppTheme.getCupertinoOverrideTheme(model.moodColor!),
                      ),
                      child: TextFormField(
                        textInputAction: TextInputAction.done,
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
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: SelectableButton(
                    color: model.moodColor,
                    onPressed: () async {
                      // if the model is read-only, unlock and focus
                      if (model.readOnly) {
                        model.setReadOnly(false);
                        model.entryFocus.requestFocus();
                      } else {
                        // if the content is identical do not call backend and pop route
                        if (model.isIdenticalContent) {
                          appRouter.pop();
                          return;
                        }

                        // push update to backend
                        final bool statusOk = await model.updateEntry();

                        if (statusOk) {
                          debugPrint("updated entry");

                          await appRouter.replace(NavigationRoute());
                        }
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
                      // retrieve deletion response from user
                      final bool deleteContinued = await model.continueDelete(context, model.moodColor!);

                      debugPrint('should delete entry: $deleteContinued');

                      if (deleteContinued) {
                        final bool statusOk = await model.deleteEntry(entry.entryId);

                        if (statusOk) {
                          debugPrint('entry deleted successfully');

                          await appRouter.replace(NavigationRoute());
                        }
                      }
                    },
                    label: "Delete Entry",
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
