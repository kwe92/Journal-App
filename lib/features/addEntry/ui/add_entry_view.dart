import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:journal_app/app/theme/colors.dart';
import 'package:journal_app/app/theme/theme.dart';
import 'package:journal_app/features/shared/ui/base_scaffold.dart';

// TODO: Work in view model | implement create entry function within JournalEntryService

@RoutePage()
class AddEntryView extends StatelessWidget {
  const AddEntryView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "Add Entry",
      // TODO: could be its own widget
      leading: IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
          size: 32,
        ),
      ),
      // TODO: refactor, same container in entry view
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 1.5,
            // width: double.maxFinite,
            margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),

            // padding: EdgeInsets.only(bottom: 24),
            decoration: const BoxDecoration(
              color: AppColors.offWhite,
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: TextField(
                // keyboardType: TextInputType.text,
                autofocus: true,
                expands: true,
                maxLines: null,
                decoration: borderlessInput,
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
                    // TODO: implement create entry
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: Text(
                      "Add Entry",
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// @RoutePage()
// class AddEntryView extends StatelessWidget {
//   const AddEntryView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BaseScaffold(
//       title: "Add Entry",
//       // TODO: could be its own widget
//       leading: IconButton(
//         onPressed: () => Navigator.of(context).pop(),
//         icon: const Icon(
//           Icons.arrow_back,
//           color: Colors.white,
//           size: 32,
//         ),
//       ),
//       // TODO: refactor, same container in entry view
//       body: Column(
//         children: [
//           Container(
//             // height: double.maxFinite,
//             // width: double.maxFinite,
//             margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),

//             // padding: EdgeInsets.only(bottom: 24),
//             decoration: const BoxDecoration(
//               color: AppColors.offWhite,
//               borderRadius: BorderRadius.all(
//                 Radius.circular(16),
//               ),
//             ),
//             child: const Padding(
//               padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
//               child: TextField(
//                 // keyboardType: TextInputType.text,
//                 autofocus: true,
//                 maxLines: 1,
//                 decoration: borderlessInput,
//               ),
//             ),
//           ),
//           SizedBox(
//             width: double.maxFinite,
//             // TODO: Add InkWell
//             child: OutlinedButton(
//               onPressed: () async {
//                 // TODO: implement create entry
//               },
//               child: const Padding(
//                 padding: EdgeInsets.symmetric(vertical: 12.0),
//                 child: Text(
//                   "Add Entry",
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
