import "package:auto_route/annotations.dart";
import "package:http/http.dart";
import "package:journal_app/app/app_router.gr.dart";
import "package:journal_app/app/resources/reusables.dart";
import "package:journal_app/app/theme/theme.dart";
import "package:journal_app/features/entry/models/updated_entry.dart";
import "package:journal_app/features/entry/ui/entry_view_model.dart";
import "package:journal_app/features/shared/models/entry.dart";
import "package:journal_app/features/shared/services/http_service.dart";
import "package:journal_app/features/shared/services/services.dart";
import "package:journal_app/features/shared/services/string_service.dart";
import "package:journal_app/features/shared/ui/base_scaffold.dart";
import "package:flutter/material.dart";
import "package:journal_app/features/shared/ui/button/custom_back_button.dart";
import "package:journal_app/features/shared/ui/button/selectable_button.dart";
import 'package:journal_app/features/shared/ui/widgets/form_container.dart';
import "package:journal_app/features/shared/utilities/popup_parameters.dart";
import "package:stacked/stacked.dart";

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
        entryController.text = model.content!;
      },
      builder: (context, model, _) {
        return BaseScaffold(
          title: entry.dateString,
          leading: CustomBackButton(
            onPressed: () {
              model.setReadOnly(true);
              appRouter.replace(JournalRoute());
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
                    validator: stringService.customStringValidator(
                      entryController.text,
                      configuration: const StringValidatorConfiguration(notEmpty: true),
                    ),
                    decoration: borderlessInput.copyWith(hintText: "What's on your mind...?"),
                    onChanged: (value) => model.setContent(value),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: SelectableButton(
                  onPressed: () async {
                    if (model.readOnly) {
                      model.setReadOnly(false);
                      entryFocus.requestFocus();
                    } else {
                      // push update to backend
                      debugPrint("update entry");

                      final Response response = await model.updateEntry(
                        UpdatedEntry(entryId: entry.entryId, content: model.content),
                      );

                      if (response.statusCode == 200 || response.statusCode == 201) {
                        toastService.showSnackBar(message: "Updated journal entry successfully.");
                        appRouter.replace(JournalRoute());
                      } else {
                        toastService.showSnackBar(message: getErrorMsg(response.body));
                      }
                    }
                  },
                  label: model.readOnly ? "Edit Entry" : "Update Entry",
                ),
              ),
              gap16,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: SelectableButton(
                  onPressed: () async {
                    final bool deleteContinued = await toastService.popupMenu<bool>(
                      context,
                      parameters: const PopupMenuParameters(
                        title: "Delete Entry",
                        content: "Are you sure you want to delete this entry?",
                        defaultResult: false,
                        options: {
                          "Delete Entry": true,
                          "Cancel": false,
                        },
                      ),
                    );

                    debugPrint('Should delete entry: $deleteContinued');

                    if (deleteContinued) {
                      final Response response = await model.deleteEntry(entry.entryId);

                      if (response.statusCode == 200 || response.statusCode == 201) {
                        toastService.showSnackBar(message: "Deleted journal entry successfully.");
                        appRouter.replace(JournalRoute());
                      } else {
                        toastService.showSnackBar(message: getErrorMsg(response.body));
                      }
                    }
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
