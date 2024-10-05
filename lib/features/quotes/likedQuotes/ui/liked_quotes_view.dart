import 'package:auto_route/annotations.dart';
import 'package:entry/entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:journal_app/app/theme/colors.dart';
import 'package:journal_app/features/quotes/likedQuotes/ui/liked_quotes_view_model.dart';
import 'package:journal_app/features/quotes/likedQuotes/ui/widgets/liked_quote_card.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:stacked/stacked.dart';

@RoutePage()
class LikedQuotesView extends StatelessWidget {
  const LikedQuotesView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ViewModelBuilder.reactive(
      // ! I think the view model is being created every time the widget is injected into the widget tree causeing extra database calls | change notifier in Navigation view maybe a better option
      viewModelBuilder: () => LikedQuotesViewModel(),
      // TODO: REDUCE BACK END CALLS | maybe refactor back to change notifier as there are too many backend calls, every time this widget is selected a database call is made
      onViewModelReady: (model) async => await model.initialize(),
      builder: (context, model, _) {
        return Scaffold(
          backgroundColor: theme.colorScheme.surface,
          appBar: model.likedQuotes.isNotEmpty
              ? AppBar(
                  scrolledUnderElevation: 0.0,
                  backgroundColor: theme.colorScheme.surface,
                  title: Container(
                    height: 52,
                    width: 52,
                    margin: EdgeInsets.only(bottom: !deviceSizeService.smallDevice ? 24 : 16, top: 16),
                    child: SvgPicture.asset(
                      "assets/images/lotus-flower-bloom.svg",
                      color: AppColors.lotusColor,
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : null,
          body: model.likedQuotes.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Entry.offset(
                        xOffset: 1000,
                        yOffset: 0,
                        duration: Duration(milliseconds: 500),
                        child: Text(
                          "Find your inspiration...",
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Entry.opacity(
                        duration: const Duration(milliseconds: 900),
                        child: SizedBox(
                          height: 300,
                          width: 300,
                          child: SvgPicture.asset(
                            "assets/images/lotus-flower-bloom.svg",
                            // color: Colors.pink[100],
                            color: AppColors.lotusColor,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: model.likedQuotes.length,
                  itemBuilder: (context, index) => LikedQuoteCard(index: index),
                ),
        );
      },
    );
  }
}
