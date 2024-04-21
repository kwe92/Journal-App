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
import 'package:journal_app/features/shared/ui/widgets/image_layout.dart';
import 'package:journal_app/features/shared/ui/widgets/profile_icon.dart';
import 'package:stacked/stacked.dart';

// TODO: Check timer conversion, as later in the day the journal entry gets set to the next day

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
      onViewModelReady: (AddEntryViewModel model) => model.initialize(moodType, DateTime.now()),
      builder: (BuildContext context, AddEntryViewModel model, _) => BaseScaffold(
        moodColor: model.moodColor,
        // Manifested in french
        title: "Manifesté",
        leading: CustomBackButton(
          color: model.moodColor,
          onPressed: () => appRouter.pop(),
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
        body: Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: SingleChildScrollView(
            child: Column(
              children: [
                FormContainer(
                  dayOfWeekByName: model.dayOfWeekByName,
                  timeOfDay: model.timeOfDay,
                  continentalTime: model.continentalTime,
                  height: model.images.isEmpty
                      ? null
                      : model.images.length < 4
                          ? MediaQuery.of(context).size.height / 2.5
                          : MediaQuery.of(context).size.height / 3.75,
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
                model.images.isNotEmpty
                    ? SizedBox(
                        height: model.images.length > 3 ? MediaQuery.of(context).size.height / 2.5 : MediaQuery.of(context).size.height / 4,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 24,
                              right: 24,
                              top: 6,
                              bottom: 24,
                            ),
                            child: SingleChildScrollView(
                              child: ImageLayout(removeImageCallback: model.removeImage, images: model.images),
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      SelectableButton(
                        color: model.moodColor,
                        onPressed: () async => await model.pickImages(),
                        label: "Add Image",
                      ),
                      const SizedBox(height: 16),
                      SelectableButton(
                        color: model.moodColor,
                        onPressed: () async {
                          if ((formKey.currentState?.validate() ?? false) && model.ready) {
                            final bool statusOk = await model.addEntry(
                              moodType,
                              model.content!,
                            );

                            if (statusOk) {
                              await appRouter.replace(NavigationRoute());
                            }
                          }
                        },
                        label: "Add Entry",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Infinitly Long TextField

//   - set TextField parameters:
//       ~ expands: true
//       ~ maxLines: null