import "package:auto_route/annotations.dart";
import "package:journal_app/features/shared/models/entry.dart";
import "package:journal_app/features/shared/ui/base_scaffold.dart";
import "package:flutter/material.dart";
import "package:journal_app/features/shared/ui/button/custom_back_button.dart";
import 'package:journal_app/features/shared/ui/widgets/form_container.dart';

// TODO: Implement edit capabilities
// TODO: Implement EntryViewModel to update entry
// TODO: add update API call to journalEntryService
// TODO: add Form, FormContainer and TextFormField instead of a text widget
// TODO: lock and unlock editing with mutable boolean variable that is in EntryViewModel
// TODO: Implement an update button | unlocks text form field and focuses on it

@RoutePage()
class EntryView extends StatelessWidget {
  final Entry entry;

  const EntryView({required this.entry, super.key});

  @override
  Widget build(BuildContext context) => BaseScaffold(
        title: entry.dateString,
        leading: CustomBackButton(
          onPressed: () => Navigator.of(context).pop(),
        ),
        body: FormContainer(
          child:
              // TODO: Replace with Form
              Text(entry.content),
        ),
      );
}
