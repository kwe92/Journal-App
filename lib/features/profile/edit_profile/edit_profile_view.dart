import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:journal_app/app/resources/reusables.dart';
import 'package:journal_app/features/profile/edit_profile/edit_profile_view.dart_model.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:journal_app/features/shared/services/string_service.dart';
import 'package:journal_app/features/shared/ui/base_scaffold.dart';
import 'package:journal_app/features/shared/ui/button/selectable_button.dart';
import 'package:journal_app/features/shared/ui/widgets/clear_icon.dart';
import 'package:stacked/stacked.dart';

// TODO: Use scroll view for TextFormFields as there maybe overflow on smaller screens

// TODO: Add the ability to edit phone number
@RoutePage()
class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => EditProfileViewModel(),
        onViewModelReady: (EditProfileViewModel viewModel) {
          viewModel.initialize();
        },
        builder: (BuildContext context, EditProfileViewModel model, _) {
          return SafeArea(
            child: BaseScaffold(
              onPressed: () => appRouter.pop(),
              title: 'Edit Profile',
              body: Column(
                children: [
                  Container(
                    width: double.maxFinite,
                    height: 210,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(model.mindfulImage!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  gap36,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Form(
                      key: model.formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            readOnly: model.readOnly,
                            controller: model.firstNameController,
                            textCapitalization: TextCapitalization.words,
                            onChanged: model.setFirstName,
                            autofillHints: const [AutofillHints.familyName],
                            validator: stringService.customStringValidator(
                              model.firstNameController.text,
                              configuration: const StringValidatorConfiguration(notEmpty: true),
                            ),
                            decoration: InputDecoration(
                              hintText: 'Enter First Name',
                              labelText: 'First Name',
                              suffixIcon: model.firstNameController.text.isNotEmpty && model.readOnly == false
                                  ? ConditionalClearIcon(controller: model.firstNameController)
                                  : null,
                            ),
                          ),
                          gap36,
                          TextFormField(
                            readOnly: model.readOnly,
                            controller: model.lastNameController,
                            textCapitalization: TextCapitalization.words,
                            onChanged: model.setLastName,
                            autofillHints: const [AutofillHints.familyName],
                            validator: stringService.customStringValidator(
                              model.firstNameController.text,
                              configuration: const StringValidatorConfiguration(notEmpty: true),
                            ),
                            decoration: InputDecoration(
                              hintText: 'Enter Last Name',
                              labelText: 'Last Name',
                              suffixIcon: model.lastNameController.text.isNotEmpty && model.readOnly == false
                                  ? ConditionalClearIcon(controller: model.lastNameController)
                                  : null,
                            ),
                          ),
                          gap36,
                          TextFormField(
                            readOnly: model.readOnly,
                            controller: model.emailController,
                            onChanged: model.setEmail,
                            autofillHints: const [AutofillHints.email],
                            validator: stringService.emailIsValid,
                            decoration: InputDecoration(
                              hintText: 'Enter Email',
                              labelText: 'Email',
                              suffixIcon: model.emailController.text.isNotEmpty && model.readOnly == false
                                  ? ConditionalClearIcon(controller: model.emailController)
                                  : null,
                            ),
                          ),
                          gap36,
                          SelectableButton(
                            onPressed: () async {
                              if (model.readOnly) {
                                model.setReadOnly(false);
                              } else {
                                if (model.formKey.currentState!.validate() && model.ready) {
                                  // attempt to update user info
                                  final bool statusOk = await model.updateUserInfo();
                                  if (statusOk) {
                                    model.clearControllers();
                                    appRouter.pop();
                                  }
                                }
                              }
                            },
                            label: model.readOnly ? "Edit" : "Update",
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
