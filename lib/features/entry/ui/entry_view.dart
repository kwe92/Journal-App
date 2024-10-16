import "package:auto_route/annotations.dart";
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
import "package:journal_app/features/shared/ui/navigation_view.dart";
import "package:journal_app/features/shared/ui/widgets/centered_loader.dart";
import "package:journal_app/features/shared/ui/widgets/custom_page_route_builder.dart";
import "package:journal_app/features/shared/ui/widgets/custom_tool_tip.dart";
import 'package:journal_app/features/shared/ui/widgets/form_container.dart';
import "package:journal_app/features/shared/ui/widgets/image_layout.dart";
import "package:journal_app/features/shared/ui/widgets/profile_icon.dart";
import "package:provider/provider.dart";
import "package:stacked/stacked.dart";

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
      onViewModelReady: (viewModel) => viewModel.initialize(),
      builder: (context, viewModel, _) {
        final expandableFabController = context.read<ExpandableFabController>();
        return BaseScaffold(
          moodColor: viewModel.moodColor,
          title: "Manifesté",
          leading: CustomBackButton(
            color: viewModel.moodColor,
            onPressed: () {
              viewModel.cancelEdit();
              Navigator.of(context).pop();
            },
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: ProfileIcon(
                userFirstName: viewModel.currentUser?.firstName ?? "P",
                color: viewModel.moodColor,
                onPressed: () {
                  // await appRouter.push(const ProfileSettingsRoute())
                },
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
                        dayOfWeekByName: viewModel.dayOfWeekByName,
                        timeOfDay: viewModel.timeOfDay,
                        continentalTime: viewModel.continentalTime,
                        child: Form(
                          key: viewModel.formKey,
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              textSelectionTheme: AppTheme.getTextSelectionThemeData(viewModel.moodColor!),
                              cupertinoOverrideTheme: AppTheme.getCupertinoOverrideTheme(viewModel.moodColor!),
                            ),
                            child: TextFormField(
                              textInputAction: TextInputAction.done,
                              controller: viewModel.entryController,
                              focusNode: viewModel.entryFocus,
                              expands: true,
                              maxLines: null,
                              textCapitalization: TextCapitalization.sentences,
                              validator: stringService.customStringValidator(
                                viewModel.entryController.text,
                                configuration: const StringValidatorConfiguration(notEmpty: true),
                              ),
                              decoration: borderlessInput.copyWith(hintText: "What's on your mind...?"),
                              onChanged: viewModel.setContent,
                            ),
                          ),
                        ),
                      ),
                    ),
                    viewModel.images.isNotEmpty
                        ? Center(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 12,
                                bottom: 12,
                              ),
                              child: SingleChildScrollView(
                                child: ImageLayout(
                                  removeImageCallback: viewModel.markImageForDeletion,
                                  images: viewModel.images,
                                ),
                              ),
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
              if (viewModel.isBusy) CenteredLoader(color: viewModel.moodColor!)
            ],
          ),
          floatingActionButton: ExpandableFab(
            backgroundColor: viewModel.moodColor,
            distance: 106,
            children: [
              CustomToolTip(
                backgroundColor: viewModel.moodColor,
                message: 'Save and exit',
                child: ActionButton(
                  backgroundColor: viewModel.moodColor,
                  icon: const Icon(
                    Icons.check,
                  ),
                  onPressed: () async {
                    expandableFabController.toggle();
                    // if the content is identical do not call backend and pop route
                    if (viewModel.isIdenticalContent) {
                      Navigator.of(context).pop();
                      return;
                    }

                    if (viewModel.formKey.currentState?.validate() ?? false) {
                      await viewModel.updateEntry();
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ),
              CustomToolTip(
                backgroundColor: viewModel.moodColor,
                margin: const EdgeInsets.only(top: 0),
                message: 'Add Image',
                child: ActionButton(
                  backgroundColor: viewModel.moodColor,
                  icon: const Icon(Icons.insert_photo),
                  onPressed: !viewModel.isBusy
                      ? () async {
                          expandableFabController.toggle();

                          await viewModel.pickImages();
                        }
                      : null,
                ),
              ),
              CustomToolTip(
                backgroundColor: viewModel.moodColor,
                margin: const EdgeInsets.only(top: 0),
                message: 'Delete',
                child: ActionButton(
                  backgroundColor: viewModel.moodColor,
                  icon: const Icon(
                    Icons.delete_forever,
                  ),
                  onPressed: () async {
                    expandableFabController.toggle();

                    // retrieve deletion response from user
                    final bool deleteContinued = await viewModel.continueDelete(context, viewModel.moodColor!);

                    debugPrint('should delete entry: $deleteContinued');

                    if (deleteContinued) {
                      final bool statusOk = await viewModel.deleteEntry(entry);

                      if (statusOk) {
                        await Navigator.of(context).pushReplacement(
                          CustomPageRouteBuilder.sharedAxisTransition(
                            transitionDuration: const Duration(milliseconds: 800),
                            pageBuilder: (_, __, ___) => const NavigationView(),
                          ),
                        );
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
