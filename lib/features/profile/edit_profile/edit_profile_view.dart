import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:journal_app/app/resources/reusables.dart';
import 'package:journal_app/features/profile/edit_profile/edit_profile_view_model.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:journal_app/features/shared/services/string_service.dart';
import 'package:journal_app/features/shared/ui/base_scaffold.dart';
import 'package:journal_app/features/shared/ui/button/selectable_button.dart';
import 'package:journal_app/features/shared/ui/widgets/clear_icon.dart';
import 'package:journal_app/features/shared/ui/widgets/profile_icon.dart';
import 'package:stacked/stacked.dart';

@RoutePage()
class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EditProfileViewModel>.reactive(
        viewModelBuilder: () => EditProfileViewModel(),
        onViewModelReady: (EditProfileViewModel viewModel) {
          viewModel.initialize();
        },
        builder: (BuildContext context, EditProfileViewModel model, _) {
          final bool smallDevice = deviceSizeService.smallDevice;

          return BaseScaffold(
            title: 'Edit Profile',
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: ProfileIcon(
                  userFirstName: model.userFirstName,
                  onPressed: () => appRouter.pop(),
                ),
              ),
            ],
            body: Column(
              children: [
                Expanded(
                  child: Center(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Form(
                            key: model.formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  readOnly: model.isReadOnly,
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
                                    suffixIcon: model.firstNameController.text.isNotEmpty && model.isReadOnly == false
                                        ? ConditionalClearIcon(controller: model.firstNameController)
                                        : null,
                                  ),
                                ),
                                gap24,
                                TextFormField(
                                  readOnly: model.isReadOnly,
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
                                    suffixIcon: model.lastNameController.text.isNotEmpty && model.isReadOnly == false
                                        ? ConditionalClearIcon(controller: model.lastNameController)
                                        : null,
                                  ),
                                ),
                                gap24,
                                TextFormField(
                                  readOnly: model.isReadOnly,
                                  controller: model.emailController,
                                  onChanged: model.setEmail,
                                  autofillHints: const [AutofillHints.email],
                                  validator: stringService.emailIsValid,
                                  decoration: InputDecoration(
                                    hintText: 'Enter Email',
                                    labelText: 'Email',
                                    suffixIcon: model.emailController.text.isNotEmpty && model.isReadOnly == false
                                        ? ConditionalClearIcon(controller: model.emailController)
                                        : null,
                                  ),
                                ),
                                gap24,
                                TextFormField(
                                  textInputAction: TextInputAction.next,
                                  controller: model.phoneNumberController,
                                  onChanged: model.setPhoneNumber,
                                  validator: stringService.customStringValidator(
                                    model.phoneNumberController.text,
                                    configuration: const StringValidatorConfiguration(
                                      notEmpty: true,
                                      includesOnlyNumbers: true,
                                      includes12Characters: true,
                                    ),
                                  ),
                                  autofillHints: const [AutofillHints.telephoneNumberNational],
                                  autovalidateMode: AutovalidateMode.disabled,
                                  keyboardType: const TextInputType.numberWithOptions(signed: true),
                                  inputFormatters: [
                                    MaskedInputFormatter('###-###-####'),
                                  ],
                                  decoration: InputDecoration(
                                      labelText: 'Phone Number',
                                      hintText: 'Enter Phone Number',
                                      // text prefixing user input
                                      prefixText: '(+1) ',
                                      suffixIcon: model.phoneNumberController.text.isNotEmpty && model.isReadOnly == false
                                          ? ConditionalClearIcon(controller: model.phoneNumberController)
                                          : null),
                                ),
                                !smallDevice ? gap48 : gap36,
                                SelectableButton(
                                  onPressed: () async {
                                    // if text fields are read only unlock them all
                                    if (model.isReadOnly) {
                                      model.setReadOnly(false);
                                    } else {
                                      debugPrint('identical info: ${model.isIdenticalInfo}');

                                      if ((model.formKey.currentState?.validate() ?? false) && model.ready) {
                                        if (model.isIdenticalInfo) {
                                          model.clearControllers();
                                          await appRouter.pop();
                                          return;
                                        }
                                        // attempt to update user info
                                        final bool statusOk = await model.updateUserInfo();

                                        if (statusOk) {
                                          debugPrint("updated user info successfully");
                                          model.clearControllers();
                                          appRouter.pop();
                                        }
                                      }
                                    }
                                  },
                                  label: model.isReadOnly ? "Edit" : "Update",
                                ),
                                // TODO: see if gap24 is needed on smaller views
                                // gap24,
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
