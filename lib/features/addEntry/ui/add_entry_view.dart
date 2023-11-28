import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:journal_app/app/app_router.gr.dart';
import 'package:journal_app/app/theme/theme.dart';
import 'package:journal_app/features/addEntry/ui/add_entry_view_model.dart';
import 'package:journal_app/features/shared/models/new_entry.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:journal_app/features/shared/ui/base_scaffold.dart';
import 'package:journal_app/features/shared/ui/button/custom_back_button.dart';
import 'package:journal_app/features/shared/ui/widgets/text_field_container.dart';
import 'package:stacked/stacked.dart';

@RoutePage()
class AddEntryView extends StatelessWidget {
  const AddEntryView({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController newEntryController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return ViewModelBuilder.reactive(
      viewModelBuilder: () => AddEntryViewModel(),
      builder: (context, model, _) => BaseScaffold(
        title: "Add Entry",
        leading: CustomBackButton(
          onPressed: () => appRouter.replace(const JournalRoute()),
        ),
        body: Column(
          children: [
            TextFieldContainer(
              height: MediaQuery.of(context).size.height / 1.5,
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                  child: TextFormField(
                    // focus text field upon inital render
                    autofocus: true,
                    expands: true,
                    maxLines: null,
                    controller: newEntryController,
                    decoration: borderlessInput,
                    onChanged: (value) => model.setContent(value),
                    // TODO: implemente validation
                    // validator: (value) {},
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: SizedBox(
                width: double.maxFinite,
                // TODO: Add InkWell
                child: Theme(
                  data: ThemeData(outlinedButtonTheme: offGreyButtonTheme),
                  child: OutlinedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate() && model.ready) {
                        await model.addEntry(NewEntry(content: model.content));
                        model.clearContent();
                        appRouter.replace(const JournalRoute());
                      } else {
                        // TODO: inform the user that the textfield can not be empty
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      child: Text("Add Entry"),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Infinitly Long TextField

//   - set TextField parameters:
//       ~ expands: true
//       ~ maxLines: null