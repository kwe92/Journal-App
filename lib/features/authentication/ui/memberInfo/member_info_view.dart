import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:journal_app/app/app_router.gr.dart';
import 'package:journal_app/app/theme/colors.dart';
import 'package:journal_app/features/authentication/models/user.dart';
import 'package:journal_app/features/authentication/ui/memberInfo/member_info_view_model.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:stacked/stacked.dart';

// TODO: add comments
// TODO: review what is going on with TextEditingController
// TODO: make more modular

@RoutePage()
class MemberInfoView extends StatelessWidget {
  MemberInfoView({super.key});

  final formKey = GlobalKey<FormState>();
  final AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  /// Text fields
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  // Should be moved to a diffrent screen | combined to one for brevity
  final TextEditingController passwordController = TextEditingController();

  /// AutoFill keys
  final GlobalObjectKey firstNameKey = const GlobalObjectKey('first');
  final GlobalObjectKey lastNameKey = const GlobalObjectKey('last');
  final GlobalObjectKey phoneNumberKey = const GlobalObjectKey('phone');
  final GlobalObjectKey emailKey = const GlobalObjectKey('email');

  /// Focus nodes | used to have a smooth flow from one text field to another
  final FocusNode firstNameFocus = FocusNode();
  final FocusNode lastNameFocus = FocusNode();
  final FocusNode phoneFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => MemberInfoViewModel(),
      onViewModelReady: (model) async {
        // create temp user for registration
        await userService.createTempUser();

        // if value is null assign empty string
        String firstName = userService.tempUser?.firstName ?? '';
        String lastName = userService.tempUser?.lastName ?? '';
        String phoneNumber = userService.tempUser?.phoneNumber ?? '';
        String email = userService.tempUser?.email ?? '';

        // Initialize values
        model.setFirstName(firstName);
        model.setLastName(lastName);
        model.setPhoneNumber(phoneNumber);
        model.setEmail(email);

        firstNameController.text = firstName;
        lastNameController.text = lastName;
      },
      builder: (context, model, child) {
        return SafeArea(
          child: Scaffold(
            body: SizedBox(
              width: double.maxFinite,
              height: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    children: [
                      Container(
                        width: double.maxFinite,
                        height: 210,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/journal_photo.avif"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 75,
                        height: 75,
                        child: IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: AppColors.offWhite,
                            size: 32,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Text(
                      "Sign-up",
                      style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Form(
                    key: formKey,
                    autovalidateMode: autoValidateMode,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 36.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          TextFormField(
                            key: firstNameKey,
                            focusNode: firstNameFocus,
                            // tell input controller to jump to next field in focus node tree
                            textInputAction: TextInputAction.next,
                            controller: firstNameController,
                            // capitalize work in text form field
                            textCapitalization: TextCapitalization.words,
                            autofillHints: const [AutofillHints.givenName],
                            onChanged: model.setFirstName,
                            // when editing commplete request focus for the next node in the focus tree (the focus node should belong to the text form field bellow)
                            onEditingComplete: () => lastNameFocus.requestFocus(),
                            // TODO add validation
                            // validator: stringService.customStringValidator(
                            //   firstNameController.text,
                            //   configuration: const StringValidatorConfiguration(notEmpty: true),
                            // ) as String? Function(String?),
                            decoration: const InputDecoration(
                              labelText: 'Legal First Name',
                              hintText: 'Enter Legal First Name',
                              // TODO: add suffix icon
                              // suffixIcon: ConditionalClearIcon(controller: firstNameController),
                            ),
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            key: lastNameKey,
                            focusNode: lastNameFocus,
                            textInputAction: TextInputAction.next,
                            textCapitalization: TextCapitalization.words,
                            controller: lastNameController,
                            onEditingComplete: () => phoneFocus.requestFocus(),
                            // TODO add validation
                            // validator: stringService.customStringValidator(
                            //   lastNameController.text,
                            //   configuration: const StringValidatorConfiguration(notEmpty: true),
                            // ) as String? Function(String?),
                            onChanged: model.setLastName,
                            autofillHints: const [AutofillHints.familyName],
                            decoration: const InputDecoration(
                              labelText: 'Legal Last Name',
                              hintText: 'Enter Legal Last Name',
                              // TODO: add suffix icon
                              // suffixIcon: ConditionalClearIcon(
                              //   controller: lastNameController,
                              // ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            key: phoneNumberKey,
                            focusNode: phoneFocus,
                            textInputAction: TextInputAction.next,
                            controller: phoneNumberController,
                            onEditingComplete: () => emailFocus.requestFocus(),
                            // TODO add validation
                            // validator: stringService.customStringValidator(
                            //   phoneNumberController.text,
                            //   configuration: const StringValidatorConfiguration(notEmpty: true),
                            // ) as String? Function(String?),
                            onChanged: model.setPhoneNumber,
                            autofillHints: const [AutofillHints.telephoneNumberNational],
                            autovalidateMode: AutovalidateMode.disabled,
                            // ? review
                            // change keyboard type automatically for the user | default to old-school 0 - 9 keyboard | signed = true for modern keyboard
                            keyboardType: const TextInputType.numberWithOptions(signed: true),
                            // TODO add inputFormatters
                            // inputFormatters: [
                            //   MaskedInputFormatter('###-###-####'),
                            // ],
                            decoration: const InputDecoration(
                              labelText: 'Phone Number',
                              hintText: 'Enter Phone Number',
                              // text prefixing user input
                              prefixText: '(+1) ',
                              // TODO: add suffix icon
                              // suffixIcon: ConditionalClearIcon(controller: phoneNumberController),
                            ),
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            key: emailKey,
                            focusNode: emailFocus,
                            // call TextInputAction.done on  final text form field
                            textInputAction: TextInputAction.done,
                            controller: emailController,
                            // TODO add validation
                            // validator: stringService.customStringValidator(
                            //   emailController.text,
                            //   configuration: const StringValidatorConfiguration(notEmpty: true),
                            // ) as String? Function(String?),
                            autofillHints: const [AutofillHints.email],
                            onChanged: model.setEmail,
                            decoration: const InputDecoration(
                              labelText: 'Email Address',
                              // hintText appears when the user selects the text form field
                              hintText: 'Enter Email Address',
                              // TODO: add suffix icon
                              // suffixIcon: ConditionalClearIcon(
                              //   controller: emailController,
                              // ),
                            ),
                          ),
                          TextFormField(
                            textInputAction: TextInputAction.done,
                            controller: passwordController,
                            focusNode: passwordFocus,
                            autofillHints: const [AutofillHints.password],
                            // TODO: add validator: replace with string service and a call to string validator
                            // validator: (String? value) {
                            // },
                            obscureText: model.obscurePassword,
                            onChanged: model.setPassword,
                            onEditingComplete: () => passwordFocus.unfocus(),
                            decoration: InputDecoration(
                              labelText: "Password",
                              hintText: "Enter Password",
                              suffixIcon: IconButton(
                                onPressed: () => model.setObscure(!model.obscurePassword),
                                icon: Icon(model.obscurePassword ? Icons.visibility_off : Icons.visibility),
                              ),
                            ),
                          ),
                          const SizedBox(height: 36),
                          SizedBox(
                            width: double.maxFinite,
                            // TODO: Add InkWell
                            child: OutlinedButton(
                              onPressed: () async {
                                // TODO: add toast service
                                // toastService.unfocusAll(context);
                                if ((formKey.currentState?.validate() ?? false) && model.ready) {
                                  final Response response = await model.signupWithEmail(user: userService.tempUser as User);

                                  if (authService.isLoggedIn) {
                                    // upon successful registration retrieve jwt token from response
                                    await tokenService.saveTokenData(jsonDecode(response.body));

                                    appRouter.replace(const JournalRoute());
                                  } else {
                                    // TODO: call toast service to display error message
                                  }
                                }
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 12.0),
                                child: Text(
                                  "Sign-up",
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
