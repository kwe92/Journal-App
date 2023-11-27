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
  Widget build(BuildContext context) => BaseScaffold(
        title: entry.dateString,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 32,
          ),
        ),
        body:
            // TODO: refactor, same container in add entry view
            Container(
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          decoration: const BoxDecoration(
            color: AppColors.offWhite,
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
          child: Text(entry.content),
        ),
      );
}
