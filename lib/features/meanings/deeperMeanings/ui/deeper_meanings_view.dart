import 'package:flutter/material.dart';
import 'package:journal_app/app/route_navigation.dart';
import 'package:journal_app/app/theme/colors.dart';
import 'package:journal_app/features/meanings/deeperMeanings/ui/deeper_meanings_view_model.dart';
import 'package:journal_app/features/meanings/deeperMeanings/ui/widgets/prompt_card.dart';
import 'package:journal_app/features/meanings/prompts/ui/prompts_view.dart';
import 'package:provider/provider.dart';

class DeeperMeaningsView extends StatelessWidget {
  const DeeperMeaningsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: ChangeNotifierProvider(
        create: (context) => DeeperMeaningsViewModel(),
        builder: (context, child) {
          final model = context.watch<DeeperMeaningsViewModel>();

          return AnimatedOpacity(
            opacity: model.isVisible ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500),
            child: CustomScrollView(
              slivers: [
                // TODO: remove duplicated code
                SliverAppBar(
                  toolbarHeight: 56,
                  forceElevated: true,
                  shadowColor: AppColors.darkGrey1.withOpacity(0.25),
                  surfaceTintColor: Colors.white,
                  automaticallyImplyLeading: false,
                  backgroundColor: Theme.of(context).colorScheme.background,
                  title: const Text(
                    "Deeper Meanings",
                    style: TextStyle(
                      // color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  sliver: SliverGrid.builder(
                    itemCount: model.prompts.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: (5 / 8),
                    ),
                    itemBuilder: (context, index) => PromptCard(
                      onTap: () async {
                        model.setVisibility(false);

                        await RouteNavigation.pushWithTransition(
                          context,
                          PromptsView(
                            promptText: model.prompts[index],
                          ),
                        );

                        model.setVisibility(true);
                      },
                      promptText: model.prompts[index],
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
