import 'package:flutter/material.dart';
import 'package:journal_app/app/general/constants.dart';
import 'package:journal_app/app/theme/colors.dart';
import 'package:journal_app/features/meanings/prompts/ui/prompts_view_model.dart';
import 'package:journal_app/features/shared/services/app_mode_service.dart';
import 'package:provider/provider.dart';

// TODO: parse text so that the text is cleaner to read

class PromptsView extends StatelessWidget {
  final String promptText;
  const PromptsView({
    required this.promptText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.watch<AppModeService>().isLightMode ? Colors.white : Theme.of(context).colorScheme.surface,
      body: ChangeNotifierProvider<PromptsViewModel>(
        create: (context) => PromptsViewModel(promptText),
        builder: (context, _) {
          final model = context.watch<PromptsViewModel>();

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                scrolledUnderElevation: 0,
                toolbarHeight: 56,
                forceElevated: true,
                shadowColor: AppColors.darkGrey1.withOpacity(0.25),
                surfaceTintColor: Colors.white,
                backgroundColor: Theme.of(context).colorScheme.surface,
                title: Text(
                  promptText,
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: FontFamily.playwrite.name,
                  ),
                ),
              ),
              model.isBusy
                  ? SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 2.75),
                        child: Center(
                          child: CircularProgressIndicator(
                            // color: Colors.blue[200],
                            color: Colors.deepPurpleAccent[100],
                          ),
                        ),
                      ),
                    )
                  : SliverToBoxAdapter(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(24),
                              child: Text(
                                parsePromptText(model.promptTextResponse) ?? "",
                                style: const TextStyle(fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
            ],
          );
        },
      ),
    );
  }
}

String? parsePromptText(String? text) {
  return text
          ?.replaceAll(":**", ":\n")
          .replaceAll("\n\n\n", "\n")
          .replaceAll(":\n", ":")
          .replaceAll(":\n", ":")
          .replaceAll(":* **", ":\n* **")
          // .replaceAll(":**", ":")
          .replaceAll(":**", ": ")
          .replaceAll(": ", ":")
          .replaceAll(":", ": ")
          .replaceAll(":*", ":\n\n-")
          .replaceAll(": ", ":\n\n")
          .replaceAll("* **", "\n")
          .replaceAll("**", "")
          .replaceAll("*", "\n-")
          .replaceAll("\n\n\n", "\n")
          .replaceAll(":\n-", ":\n\n`-")

      // TODO: replace we | our | yourselves
      // .replaceAllMapped("and", (match) => "")
      // .replaceAll("we", "you")
      // .replaceAll("We", "You")
      // .replaceAll("our", "your")
      // .replaceAll("Our", "Your")
      // .replaceAll("yourselves", "yourself")
      // .replaceAll("Yourselves", "Yourself")
      ;
}

// Center(
//                   child: Column(
//                     children: [
//                       Expanded(
//                         child: SingleChildScrollView(
//                           child: Column(
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.all(24),
//                                 child: Text(
//                                   model.promptTextResponse ?? "",
//                                   style: const TextStyle(fontSize: 18),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
