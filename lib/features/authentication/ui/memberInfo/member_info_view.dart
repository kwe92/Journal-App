import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:journal_app/app/app_router.gr.dart';
import 'package:journal_app/app/resources/reusables.dart';
import 'package:journal_app/features/authentication/ui/memberInfo/member_info_view_model.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:journal_app/features/shared/services/string_service.dart';
import 'package:journal_app/features/shared/ui/button/custom_back_button.dart';
import 'package:journal_app/features/shared/ui/button/selectable_button.dart';
import 'package:journal_app/features/shared/ui/widgets/clear_icon.dart';
import 'package:journal_app/features/shared/utilities/widget_keys.dart';
import 'package:stacked/stacked.dart';

@RoutePage()
class MemberInfoView extends StatelessWidget {
  MemberInfoView({super.key});

  // required to track form and validate the forms text fields
  final formKey = GlobalKey<FormState>();

  final AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  /// Text controllers
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  /// Focus nodes | used to have a smooth flow from one text field to another
  final FocusNode firstNameFocus = FocusNode();
  final FocusNode lastNameFocus = FocusNode();
  final FocusNode phoneFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MemberInfoViewModel>.reactive(
      viewModelBuilder: () => MemberInfoViewModel(),
      onViewModelReady: (MemberInfoViewModel model) async {
        await model.initialize();
        firstNameController.text = model.firstName!;
        lastNameController.text = model.lastName!;
      },
      builder: (BuildContext context, MemberInfoViewModel model, _) {
        final smallDevice = deviceSizeService.smallDevice;

        return SafeArea(
          child: Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
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
                        height: MediaQuery.of(context).size.height / (!smallDevice ? 3.125 : 3.5),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: model.mindfulImage!,
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
                  !smallDevice ? gap12 : gap6,
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      "Sign-up",
                      style: TextStyle(
                        fontSize: !smallDevice ? 32 : 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  !smallDevice ? gap12 : const SizedBox(),
                  Expanded(
                    child: CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: Form(
                            key: formKey,
                            autovalidateMode: autoValidateMode,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 24.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  TextFormField(
                                    key: WidgetKey.firstNameKey,
                                    focusNode: firstNameFocus,
                                    textInputAction: TextInputAction.next,
                                    controller: firstNameController,
                                    // capitalize word in text form field
                                    textCapitalization: TextCapitalization.words,
                                    autofillHints: const [AutofillHints.givenName],
                                    onChanged: model.setFirstName,
                                    onEditingComplete: () => lastNameFocus.requestFocus(),
                                    validator: stringService.customStringValidator(
                                      firstNameController.text,
                                      configuration: const StringValidatorConfiguration(notEmpty: true),
                                    ),
                                    decoration: InputDecoration(
                                      labelText: 'Legal First Name',
                                      hintText: 'Enter Legal First Name',
                                      suffixIcon: firstNameController.text.isNotEmpty
                                          ? ConditionalClearIcon(controller: firstNameController)
                                          : null,
                                    ),
                                  ),
                                  !smallDevice ? gap12 : const SizedBox(),
                                  TextFormField(
                                    key: WidgetKey.lastNameKey,
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
                                  !smallDevice ? gap12 : const SizedBox(),
                                  TextFormField(
                                    key: WidgetKey.phoneNumberKey,
                                    focusNode: phoneFocus,
                                    textInputAction: TextInputAction.next,
                                    controller: phoneNumberController,
                                    onChanged: model.setPhoneNumber,
                                    onEditingComplete: () => emailFocus.requestFocus(),
                                    validator: stringService.customStringValidator(
                                      phoneNumberController.text,
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
                                      suffixIcon: phoneNumberController.text.isNotEmpty
                                          ? ConditionalClearIcon(controller: phoneNumberController)
                                          : null,
                                    ),
                                  ),
                                  !smallDevice ? gap12 : const SizedBox(),
                                  TextFormField(
                                    key: WidgetKey.emailKey,
                                    focusNode: emailFocus,
                                    textInputAction: TextInputAction.done,
                                    controller: emailController,
                                    validator: stringService.emailIsValid,
                                    autofillHints: const [AutofillHints.email],
                                    onChanged: model.setEmail,
                                    onEditingComplete: () => emailFocus.unfocus(),
                                    decoration: InputDecoration(
                                      labelText: 'Email Address',
                                      hintText: 'Enter Email Address',
                                      suffixIcon:
                                          emailController.text.isNotEmpty ? ConditionalClearIcon(controller: emailController) : null,
                                    ),
                                  ),
                                  !smallDevice ? gap36 : gap24,
                                  SelectableButton(
                                    onPressed: () async {
                                      if (formKey.currentState!.validate() && model.ready) {
                                        // check email availability
                                        final bool statusOk = await model.checkAvailableEmail(email: model.email!);

                                        // continue to signup view if email available else show user an error snack bar
                                        if (statusOk) {
                                          appRouter.push(SignUpRoute());
                                        }
                                      }
                                    },
                                    label: "Continue",
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


// keyboardType | property TextFormField

//   - change keyboard type automatically for the user
//   - const TextInputType.numberWithOptions(signed: true):
//       - defaults to old-school 0 - 9 keyboard
//       -  signed = true (for modern keyboard)


// Focus on Next Input Field in Focus Tree | textInputAction | onEditingComplete

//   - tell input controller to jump to next TextField in focus node tree
//   - when editing commplete request focus for next focus node in focus tree 
//     the next focus node should belong to the TextField

// CustomScrollView

//   - sub-type of ScrollView that allows custom scroll effects with slivers
//   - analogous to ListView with scrolling effects
//   - children of a CustomScrollView are RenderSliver's (SliverToBoxAdapter, SliverList, etc)
//   - where as ListView's children are RenderBox's (Container, Row, Column etc)

// Slivers

//   - portion of a scrollable area that can be configured in different ways
//   - slivers can be combined to create custom scroll effects
//   - Sliver objects begin with a sliver prefix

// Sliver Memory Footprint

//   - slivers are lazily built by their parent only being created
//     once visible in the view port

// Categories of Scrolling

//   - Scrolling without effects (ListView)

//       - children are Renderbox's: basic two dimensional objects on the cartesian plane

//   - Scrolling with effects (CustomScrollView)

//       - children are RenderSliver's (slivers for brevity): advanced constraints and geometry

// Creating ViewModel Declaratively

//   - you create ViewModel's declaratively with the stacked framework     
//     by passing an anonymous function that instantiates the ViewModel
//     to the viewModelBuild property of the ViewModelBuilder class