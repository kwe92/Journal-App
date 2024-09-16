import 'package:flutter/material.dart';
import 'package:journal_app/features/journal/ui/journal_view_model.dart';
import 'package:journal_app/features/shared/models/journal_entry.dart';
import 'package:journal_app/features/shared/ui/widgets/image_layout.dart';
import 'package:provider/provider.dart';

class JournalContent extends StatelessWidget {
  // final VoidCallback onPressed;

  final Color moodBackgroundColor;

  final JournalEntry journalEntry;

  const JournalContent({
    // required this.onPressed,
    required this.moodBackgroundColor,
    required this.journalEntry,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<JournalViewModel>();
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: moodBackgroundColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      child: Column(
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(
              minHeight: 150,
              maxHeight: 250,
              minWidth: double.infinity,
            ),
            child: Padding(
              // padding: const EdgeInsets.only(left: 16, right: 16, top: 24),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),

              child: Text(
                journalEntry.content,
                overflow: TextOverflow.fade,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0, bottom: 8.0, right: 12.0),
            child: ImageLayout(
              images: viewModel.convertToImageProvider(journalEntry.images),
            ),
          ),
        ],
      ),
    );
  }
}

// Create RenderBox That Starts at Min Height Grows to Max Height

//   - most RenderBox's have a default infinite width and height
//   - in order to have a growable RenderBox you must use a DecoratedBox widget
//   - DecoratedBox widgets have a default height and width of 0
//   - wrapping a DecoratedBox with a ContrainedBox and adding minimum and maximum contraints
//     allows the chidren of a DecoratedBox to be growable from the minimum size to the maximum size


// !Old version pre dev-2.0

  //  GestureDetector(
  //     onTap: onPressed,
  //     child: ConstrainedBox(
  //       constraints: const BoxConstraints(
  //         minHeight: 150,
  //         maxHeight: 250,
  //         minWidth: double.infinity,
  //       ),
  //       child: Padding(
  //         padding: const EdgeInsets.symmetric(horizontal: 16),
  //         child: DecoratedBox(
  //           decoration: BoxDecoration(
  //             color: moodBackgroundColor,
  //             borderRadius: const BorderRadius.all(
  //               Radius.circular(16),
  //             ),
  //           ),
  //           child: Padding(
  //             // padding: const EdgeInsets.only(left: 16, right: 16, top: 24),
  //             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),

  //             child: Text(
  //               content,
  //               overflow: TextOverflow.fade,
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );