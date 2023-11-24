import "package:auto_route/annotations.dart";
import "package:journal_app/app/theme/colors.dart";
import "package:journal_app/features/shared/models/entry.dart";
import "package:journal_app/features/shared/ui/base_scaffold.dart";
import "package:flutter/material.dart";

@RoutePage()
class EntryView extends StatelessWidget {
  final Entry entry;

  const EntryView({required this.entry, super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: entry.createdDate,
      leading:
          // TODO: replace with image from figma
          IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
          size: 32,
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(
          left: 24,
          top: 32,
          right: 24,
          bottom: 32,
        ),
        // padding: EdgeInsets.only(bottom: 24),
        decoration: const BoxDecoration(
          color: AppColors.offWhite,
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        child:
            // TODO: Replace with entry
            Text(entry.entry),
      ),
    );
  }
}
