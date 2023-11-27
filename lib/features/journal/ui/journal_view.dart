import 'package:auto_route/auto_route.dart';
import 'package:journal_app/app/app_router.gr.dart';
import 'package:journal_app/features/journal/ui/journal_view_model.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:journal_app/features/shared/ui/base_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:journal_app/app/theme/colors.dart';
import 'package:stacked/stacked.dart';

@RoutePage()
class JournalView extends StatelessWidget {
  const JournalView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => JournalViewModel(),
      onViewModelReady: (model) async {
        await model.initialize();
        debugPrint("\nfrom JournalView: ${model.journalEntries}");
      },
      builder: (context, model, child) {
        return BaseScaffold(
          title: "MyJournel",
          leading: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SvgPicture.asset("assets/images/menu_icon.svg"),
          ),
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.blue0,
                  AppColors.blueGrey0,
                ],
              ),
            ),
            child: Container(
              margin: const EdgeInsets.only(
                left: 24,
                top: 32,
                right: 24,
                bottom: 32,
              ),
              // padding: EdgeInsets.only(bottom: 24),
              decoration: BoxDecoration(
                color: AppColors.journalBackground.withOpacity(0.25),
                borderRadius: const BorderRadius.all(
                  Radius.circular(16),
                ),
              ),
              child: ListView.builder(
                itemCount: model.journalEntries.length,
                itemBuilder: (BuildContext context, int i) {
                  return Padding(
                    padding: EdgeInsets.only(top: i == 0 ? 32 : 0, bottom: 42),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(model.journalEntries[i].dateString),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        GestureDetector(
                          onTap: () => appRouter.push(
                            EntryRoute(entry: model.journalEntries[i]),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.only(left: 24, right: 16),
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            height: 52,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: AppColors.offWhite,
                              borderRadius: BorderRadius.all(
                                Radius.circular(52 / 2),
                              ),
                            ),
                            child: Text(
                              model.journalEntries[i].content,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          floatingActionButton: AddButton(onTap: () {
            // TODO: implement adding entry
          }),
        );
      },
    );
  }
}

// BUTTON

class AddButton extends StatelessWidget {
  final VoidCallback onTap;

  const AddButton({
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const double size = 64;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(
          left: 32,
          top: 32,
          right: 32,
          bottom: 56,
        ),
        width: size,
        height: size,
        decoration: const BoxDecoration(
          color: AppColors.offGrey,
          borderRadius: BorderRadius.all(
            Radius.circular(size / 2),
          ),
        ),
        child: const Icon(
          Icons.add,
          color: AppColors.offWhite,
          size: 52,
        ),
      ),
    );
  }
}

// ENTRY MODEL
