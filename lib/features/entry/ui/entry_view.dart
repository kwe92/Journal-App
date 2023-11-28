import "package:auto_route/annotations.dart";
import "package:http/http.dart";
import "package:journal_app/app/app_router.gr.dart";
import "package:journal_app/app/theme/theme.dart";
import "package:journal_app/features/entry/models/updated_entry.dart";
import "package:journal_app/features/entry/ui/entry_view_model.dart";
import "package:journal_app/features/shared/models/entry.dart";
import "package:journal_app/features/shared/services/services.dart";
import "package:journal_app/features/shared/ui/base_scaffold.dart";
import "package:flutter/material.dart";
import "package:journal_app/features/shared/ui/button/custom_back_button.dart";
import "package:journal_app/features/shared/ui/button/selectable_button.dart";
import 'package:journal_app/features/shared/ui/widgets/form_container.dart';
import "package:stacked/stacked.dart";

// TODO: Implement deleting an entry
// TODO: add toast service / modal to ask user are then sure they want to delete an entry
// TODO: maybe add an potion to turn the modal off and add an option to toggle modal in settings

@RoutePage()
class EntryView extends StatelessWidget {
  final Entry entry;

  EntryView({required this.entry, super.key});

  final TextEditingController entryController = TextEditingController();

  final FocusNode entryFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => EntryviewModel(),
      onViewModelReady: (model) {
        model.content = entry.content;
        entryController.text = model.content as String;
      },
      builder: (context, model, _) {
        return BaseScaffold(
          title: entry.dateString,
          leading: CustomBackButton(
            onPressed: () {
              model.setReadOnly(true);
              appRouter.replace(const JournalRoute());
            },
          ),
          body: Column(
            children: [
              FormContainer(
                height: MediaQuery.of(context).size.height / 1.65,
                child: Form(
                  child: TextFormField(
                    controller: entryController,
                    focusNode: entryFocus,
                    expands: true,
                    maxLines: null,
                    readOnly: model.readOnly,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: borderlessInput.copyWith(hintText: "What's on your mind...?"),
                    onChanged: (value) => model.setContent(value),
                  ),
                ),
              ),
              // TODO: implement edit button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: SelectableButton(
                  mainTheme: offGreyButtonTheme,
                  onPressed: () async {
                    if (model.readOnly) {
                      model.setReadOnly(false);
                      entryFocus.requestFocus();
                    } else {
                      // push update to backend
                      debugPrint("update entry");

                      // TODO: check response
                      final Response response = await model.updateEntry(
                        UpdatedEntry(entryId: entry.entryId, content: model.content),
                      );

                      appRouter.replace(const JournalRoute());

                      debugPrint("response status code from EntryView update: ${response.statusCode}");
                      // TODO: context.read<JournalViewModel>.refresh ?? | try to implement the method and see if the journal view is refreshed
                    }
                  },
                  label: model.readOnly ? "Edit Entry" : "Update Entry",
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: SelectableButton(
                  mainTheme: offGreyButtonTheme,
                  onPressed: () async {
                    // TODO: implement delete entry and add toast service to confirm
                    final Response response = await model.deleteEntry(entry.entryId);
                    debugPrint("response status code from EntryView delete: ${response.statusCode}");
                    appRouter.replace(const JournalRoute());
                  },
                  label: "Delete Entry",
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
