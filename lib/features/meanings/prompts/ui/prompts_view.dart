import 'package:flutter/material.dart';
import 'package:journal_app/app/theme/colors.dart';
import 'package:journal_app/features/meanings/prompts/ui/prompts_view_model.dart';
import 'package:journal_app/features/shared/services/app_mode_service.dart';
import 'package:provider/provider.dart';

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
      appBar: AppBar(
        // backgroundColor: Theme.of(context).colorScheme.primary,
        // backgroundColor: Colors.blue[200],
        backgroundColor: AppColors.darkGrey0,

        title: Text(
          promptText,
          style: const TextStyle(fontSize: 24),
        ),
      ),
      body: ChangeNotifierProvider<PromptsViewModel>(
        create: (context) => PromptsViewModel(promptText),
        builder: (context, _) {
          final model = context.watch<PromptsViewModel>();

          return model.isBusy
              ? Center(
                  child: CircularProgressIndicator(
                  // color: Colors.blue[200],
                  color: Colors.deepPurpleAccent[100],
                ))
              : Center(
                  child: Column(
                    children: [
                      Expanded(
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
                  ),
                );
        },
      ),
    );
  }
}
