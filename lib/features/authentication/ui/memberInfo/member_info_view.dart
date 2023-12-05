import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:http/http.dart';
import 'package:journal_app/app/app_router.gr.dart';
import 'package:journal_app/app/resources/reusables.dart';
import 'package:journal_app/features/authentication/models/user.dart';
import 'package:journal_app/features/authentication/ui/memberInfo/member_info_view_model.dart';
import 'package:journal_app/features/shared/services/http_service.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:journal_app/features/shared/services/string_service.dart';
import 'package:journal_app/features/shared/ui/button/custom_back_button.dart';
import 'package:journal_app/features/shared/ui/button/selectable_button.dart';
import 'package:journal_app/features/shared/ui/widgets/clear_icon.dart';
import 'package:stacked/stacked.dart';

@RoutePage()
class MemberInfoView extends StatelessWidget {
  MemberInfoView({super.key});

  // required to track form and validate the forms text fields
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

  final image = imageService.getRandomMindfulImage();

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
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(image),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 75,
                        height: 75,
                        child: CustomBackButton(
                          color: Colors.white,
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      )
                    ],
                  ),
                  gap12,
                  const Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Text(
                      "Sign-up",
                      style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
                    ),
                  ),
                  gap12,
                  Expanded(
                    child: CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: Form(
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
                                    textInputAction: TextInputAction.next,
                                    controller: firstNameController,
                                    // capitalize word in text form field
                                    textCapitalization: TextCapitalization.words,
                                    autofillHints: const [AutofillHints.givenName],
                                    onChanged: model.setFirstName,
                                    onEditingComplete: () => lastNameFocus.requestFocus(),
                                    validator: stringService.customStringValidator(firstNameController.text,
                                        configuration: const StringValidatorConfiguration(notEmpty: true)),
                                    decoration: InputDecoration(
                                      labelText: 'Legal First Name',
                                      hintText: 'Enter Legal First Name',
                                      suffixIcon: firstNameController.text.isNotEmpty
                                          ? ConditionalClearIcon(controller: firstNameController)
                                          : null,
                                    ),
                                  ),
                                  gap12,
                                  TextFormField(
                                    key: lastNameKey,
                                    focusNode: lastNameFocus,
                                    textInputAction: TextInputAction.next,
                                    textCapitalization: TextCapitalization.words,
                                    controller: lastNameController,
                                    onChanged: model.setLastName,
                                    onEditingComplete: () => phoneFocus.requestFocus(),
                                    validator: stringService.customStringValidator(lastNameController.text,
                                        configuration: const StringValidatorConfiguration(notEmpty: true)),
                                    autofillHints: const [AutofillHints.familyName],
                                    decoration: InputDecoration(
                                      labelText: 'Legal Last Name',
                                      hintText: 'Enter Legal Last Name',
                                      suffixIcon:
                                          lastNameController.text.isNotEmpty ? ConditionalClearIcon(controller: lastNameController) : null,
                                    ),
                                  ),
                                  gap12,
                                  TextFormField(
                                    key: phoneNumberKey,
                                    focusNode: phoneFocus,
                                    textInputAction: TextInputAction.next,
                                    controller: phoneNumberController,
                                    onChanged: model.setPhoneNumber,
                                    onEditingComplete: () => emailFocus.requestFocus(),
                                    validator: stringService.customStringValidator(
                                      phoneNumberController.text,
                                      configuration: const StringValidatorConfiguration(notEmpty: true),
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
                                      suffixIcon: phoneNumberController.text.isNotEmpty
                                          ? ConditionalClearIcon(controller: phoneNumberController)
                                          : null,
                                    ),
                                  ),
                                  gap12,
                                  TextFormField(
                                    key: emailKey,
                                    focusNode: emailFocus,
                                    textInputAction: TextInputAction.next,
                                    controller: emailController,
                                    validator: stringService.emailIsValid,
                                    autofillHints: const [AutofillHints.email],
                                    onChanged: model.setEmail,
                                    onEditingComplete: () => passwordFocus.requestFocus(),
                                    decoration: InputDecoration(
                                      labelText: 'Email Address',
                                      hintText: 'Enter Email Address',
                                      suffixIcon:
                                          emailController.text.isNotEmpty ? ConditionalClearIcon(controller: emailController) : null,
                                    ),
                                  ),
                                  TextFormField(
                                    // call TextInputAction.done on final text form field
                                    textInputAction: TextInputAction.done,
                                    controller: passwordController,
                                    focusNode: passwordFocus,
                                    autofillHints: const [AutofillHints.password],
                                    validator: stringService.passwordIsValid,
                                    obscureText: model.obscurePassword,
                                    onChanged: model.setPassword,
                                    // unfocus the final text field in the focus tree
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
                                  gap36,
                                  SelectableButton(
                                    onPressed: () async {
                                      toastService.unfocusAll(context);
                                      if ((formKey.currentState?.validate() ?? false) && model.ready) {
                                        // upon successful validation sign the user up.
                                        final Response response = await model.signupWithEmail(user: userService.tempUser as User);

                                        switch (response.statusCode) {
                                          // failed status codes
                                          case 209 || 400 || 401 || 403 || 550:
                                            toastService.showSnackBar(
                                              message: getErrorMsg(response.body),
                                            );
                                          // success status codes
                                          case 200 || 201:
                                            if (authService.isLoggedIn) {
                                              // upon successful registration retrieve jwt token from response
                                              await tokenService.saveTokenData(
                                                jsonDecode(response.body),
                                              );

                                              // remove member info view and navigate to journal view | there maybe a better way to refresh widget
                                              appRouter.replace(JournalRoute());
                                            } else {
                                              toastService.showSnackBar();
                                            }
                                        }
                                      }
                                    },
                                    label: "Sign-up",
                                  ),
                                  gap24,
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
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


// Keyboard Type | property TextFormField

//   - change keyboard type automatically for the user
//   - defaults to old-school 0 - 9 keyboard
//   -  signed = true for modern keyboard


// Focus on Next Input Field in Focus Tree | textInputAction | onEditingComplete

//   - tell input controller to jump to next field in focus node tree
//   - when editing commplete request focus for next focus node in focus tree 
//     the next focus node should belong to the text form field above the requester 

// CustomScrollView

//   - sub-type of ScrollView that allows custom scroll effects with slivers
//   - analogous to ListView with scrolling effects
//   - the children of a CustomScrollView are RenderSliver's (SliverToBoxAdapter, SliverList, et)
//   - where as ListView's children are RenderBox's (Container, Row, Column etc)

// Slivers

//   - portion of a scrollable area that can be configured in diffrent ways
//   - slivers can be combined to create custom scroll effects
//   - Sliver objects begin with a sliver prefix

// Sliver Memory Footprint

//   - slivers are lazily built by their parent only being created
//     once visible in the view port

// Catigories of Scrolling

//   - Scrolling without effects (ListView)

//       - children are Renderbox's: basic two demmentional objects on the cartesian plane

//   - Scrolling with effects (CustomScrollView)

//       - children are RenderSliver's (slivers for brevity): advanced constraints and geometry


