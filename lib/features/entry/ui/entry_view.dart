import "package:auto_route/annotations.dart";
import "package:journal_app/app/app_router.gr.dart";
import "package:journal_app/app/theme/theme.dart";
import "package:journal_app/features/entry/ui/entry_view_model.dart";
import 'package:journal_app/features/shared/models/journal_entry.dart';
import "package:journal_app/features/shared/services/services.dart";
import "package:journal_app/features/shared/services/string_service.dart";
import "package:journal_app/features/shared/ui/base_scaffold.dart";
import "package:flutter/material.dart";
import "package:journal_app/features/shared/ui/button/custom_back_button.dart";
import "package:journal_app/features/shared/ui/button/expandingFab/action_button.dart";
import "package:journal_app/features/shared/ui/button/expandingFab/controllers/expandable_fab_controller.dart";
import "package:journal_app/features/shared/ui/button/expandingFab/expandable_fab.dart";
import "package:journal_app/features/shared/ui/widgets/centered_loader.dart";
import "package:journal_app/features/shared/ui/widgets/custom_tool_tip.dart";
import 'package:journal_app/features/shared/ui/widgets/form_container.dart';
import "package:journal_app/features/shared/ui/widgets/image_layout.dart";
import "package:journal_app/features/shared/ui/widgets/profile_icon.dart";
import "package:provider/provider.dart";
import "package:stacked/stacked.dart";

//!! TODO: Ensure that the entry is updated properly in entry service

@RoutePage()
class EntryView extends StatelessWidget {
  final JournalEntry entry;

  const EntryView({
    required this.entry,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EntryViewModel>.reactive(
      viewModelBuilder: () => EntryViewModel(entry: entry),
      onViewModelReady: (EntryViewModel model) => model.initialize(),
      builder: (context, EntryViewModel model, _) {
        final expandableFabController = context.read<ExpandableFabController>();
        return BaseScaffold(
          moodColor: model.moodColor,
          title: "Manifesté",
          leading: CustomBackButton(
            color: model.moodColor,
            onPressed: appRouter.pop,
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
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 24,
                  top: 16,
                  right: 24,
                  bottom: 32,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: FormContainer(
                        dayOfWeekByName: model.dayOfWeekByName,
                        timeOfDay: model.timeOfDay,
                        continentalTime: model.continentalTime,
                        child: Form(
                          key: model.formKey,
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
                              textCapitalization: TextCapitalization.sentences,
                              validator: stringService.customStringValidator(
                                model.entryController.text,
                                configuration: const StringValidatorConfiguration(notEmpty: true),
                              ),
                              decoration: borderlessInput.copyWith(hintText: "What's on your mind...?"),
                              onChanged: model.setContent,
                            ),
                          ),
                        ),
                      ),
                    ),
                    model.images.isNotEmpty
                        ? Center(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 12,
                                bottom: 12,
                              ),
                              child: SingleChildScrollView(
                                child: ImageLayout(
                                  removeImageCallback: model.markImageForDeletion,
                                  images: model.images,
                                ),
                              ),
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
              if (model.isBusy) CenteredLoader(color: model.moodColor!)
            ],
          ),
          floatingActionButton: ExpandableFab(
            backgroundColor: model.moodColor,
            distance: 106,
            children: [
              CustomToolTip(
                backgroundColor: model.moodColor,
                message: 'Save and exit',
                child: ActionButton(
                  backgroundColor: model.moodColor,
                  icon: const Icon(
                    Icons.check,
                  ),
                  onPressed: () async {
                    expandableFabController.toggle();
                    // if the content is identical do not call backend and pop route
                    if (model.isIdenticalContent) {
                      appRouter.pop();
                      return;
                    }

                    if (model.formKey.currentState?.validate() ?? false) {
                      await model.updateEntry();

                      await appRouter.replace(NavigationRoute());
                    }
                  },
                ),
              ),
              CustomToolTip(
                backgroundColor: model.moodColor,
                margin: const EdgeInsets.only(top: 0),
                message: 'Add Image',
                child: ActionButton(
                  backgroundColor: model.moodColor,
                  icon: const Icon(
                    Icons.insert_photo,
                  ),
                  onPressed: !model.isBusy
                      ? () async {
                          expandableFabController.toggle();

                          await model.pickImages();
                        }
                      : null,
                ),
              ),
              CustomToolTip(
                backgroundColor: model.moodColor,
                margin: const EdgeInsets.only(top: 0),
                message: 'Delete',
                child: ActionButton(
                  backgroundColor: model.moodColor,
                  icon: const Icon(
                    Icons.delete_forever,
                  ),
                  onPressed: () async {
                    expandableFabController.toggle();

                    // retrieve deletion response from user
                    final bool deleteContinued = await model.continueDelete(context, model.moodColor!);

                    debugPrint('should delete entry: $deleteContinued');

                    if (deleteContinued) {
                      final bool statusOk = await model.deleteEntry(entry);

                      if (statusOk) {
                        debugPrint('entry deleted successfully');

                        await appRouter.replace(NavigationRoute());
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
