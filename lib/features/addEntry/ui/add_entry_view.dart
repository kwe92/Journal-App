import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:journal_app/app/app_router.gr.dart';
import 'package:journal_app/app/theme/theme.dart';
import 'package:journal_app/features/addEntry/ui/add_entry_view_model.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:journal_app/features/shared/services/string_service.dart';
import 'package:journal_app/features/shared/ui/base_scaffold.dart';
import 'package:journal_app/features/shared/ui/button/custom_back_button.dart';
import 'package:journal_app/features/shared/ui/button/expandingFab/action_button.dart';
import 'package:journal_app/features/shared/ui/button/expandingFab/controllers/expandable_fab_controller.dart';
import 'package:journal_app/features/shared/ui/button/expandingFab/expandable_fab.dart';
import 'package:journal_app/features/shared/ui/navigation_view.dart';
import 'package:journal_app/features/shared/ui/widgets/centered_loader.dart';
import 'package:journal_app/features/shared/ui/widgets/custom_tool_tip.dart';
import 'package:journal_app/features/shared/ui/widgets/form_container.dart';
import 'package:journal_app/features/shared/ui/widgets/image_layout.dart';
import 'package:journal_app/features/shared/ui/widgets/profile_icon.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

//!! TODO: Check timer conversion, as later in the day the journal entry gets set to the next day

@immutable
@RoutePage()
class AddEntryView extends StatelessWidget {
  final String moodType;

  const AddEntryView({required this.moodType, super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return ViewModelBuilder<AddEntryViewModel>.reactive(
        viewModelBuilder: () => AddEntryViewModel(),
        onViewModelReady: (AddEntryViewModel model) => model.initialize(moodType),
        builder: (BuildContext context, AddEntryViewModel model, _) {
          final expandableFabController = context.read<ExpandableFabController>();

          return BaseScaffold(
            moodColor: model.moodColor,
            // Manifested in french
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
                            key: formKey,
                            child: Theme(
                              data: Theme.of(context).copyWith(
                                textSelectionTheme: AppTheme.getTextSelectionThemeData(model.moodColor!),
                                cupertinoOverrideTheme: AppTheme.getCupertinoOverrideTheme(model.moodColor!),
                              ),
                              child: TextFormField(
                                // used to control the native keyboard option
                                textInputAction: TextInputAction.done,
                                // focus text field upon inital render
                                autofocus: true,
                                expands: true,
                                maxLines: null,
                                // automatically capitalize sentences for user
                                textCapitalization: TextCapitalization.sentences,
                                controller: model.newEntryController,
                                decoration: borderlessInput.copyWith(hintText: "What's on your mind...?"),
                                onChanged: model.setContent,
                                validator: stringService.customStringValidator(
                                  model.newEntryController.text,
                                  configuration: const StringValidatorConfiguration(notEmpty: true),
                                ),
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
                                    removeImageCallback: model.removeImage,
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
              distance: 96.0,
              angleInDegrees: 16.0,
              step: 60.0,
              backgroundColor: model.moodColor,
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
                      if ((formKey.currentState?.validate() ?? false) && model.ready) {
                        final bool statusOk = await model.addEntry(
                          moodType,
                          model.content!,
                        );

                        if (statusOk) {
                          await Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const NavigationView()));
                        }
                      }
                    },
                  ),
                ),
                CustomToolTip(
                  backgroundColor: model.moodColor,
                  message: 'Add image',
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
              ],
            ),
          );
        });
  }
}

// Infinitly Long TextField

//   - set TextField parameters:

//       ~ expands: true

//       ~ maxLines: null