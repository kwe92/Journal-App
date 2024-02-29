import 'package:flutter/material.dart';
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
      backgroundColor: context.watch<AppModeService>().isLightMode ? Colors.white : Theme.of(context).colorScheme.background,
      body: ChangeNotifierProvider<PromptsViewModel>(
        create: (context) => PromptsViewModel(promptText),
        builder: (context, _) {
          final model = context.watch<PromptsViewModel>();

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                toolbarHeight: 56,
                forceElevated: true,
                shadowColor: AppColors.darkGrey1.withOpacity(0.25),
                surfaceTintColor: Colors.white,
                backgroundColor: Theme.of(context).colorScheme.background,
                title: Text(
                  promptText,
                  style: const TextStyle(fontSize: 24),
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
                                model.promptTextResponse ?? "",
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