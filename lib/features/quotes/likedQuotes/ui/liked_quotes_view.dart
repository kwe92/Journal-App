import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:journal_app/app/theme/colors.dart';
import 'package:journal_app/features/quotes/likedQuotes/ui/liked_quotes_view_model.dart';
import 'package:journal_app/features/quotes/likedQuotes/ui/widgets/liked_quote_card.dart';
import 'package:stacked/stacked.dart';

@RoutePage()
class LikedQuotesView extends StatelessWidget {
  const LikedQuotesView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      // ! I think the view model is being created every time the widget is injected into the widget tree causeing extra backend calls | change notifier in Navigation view maybe a better option
      viewModelBuilder: () => LikedQuotesViewModel(),
      // TODO: REDUCE BACK END CALLS | maybe refactor back to change notifier as there are too many backend calls, every time this widget is selected a backend csall is made
      onViewModelReady: (model) async => await model.initialize(),
      builder: (context, model, _) {
        return Scaffold(
          backgroundColor: AppColors.darkGrey1,
          appBar: model.likedQuotes.isNotEmpty
              ? AppBar(
                  scrolledUnderElevation: 0.0,
                  backgroundColor: AppColors.darkGrey1,
                  title: Container(
                    height: 52,
                    width: 52,
                    margin: const EdgeInsets.only(bottom: 16),
                    child: SvgPicture.asset(
                      "assets/images/lotus-flower-bloom.svg",
                      color: Colors.pink[100],
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
                      const Text(
                        "Find your inspiration...",
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 300,
                        width: 300,
                        child: SvgPicture.asset(
                          "assets/images/lotus-flower-bloom.svg",
                          color: Colors.pink[100],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: model.likedQuotes.length,
                  itemBuilder: (context, index) {
                    return LikedQuoteCard(
                      index: index,
                    );
                  },
                ),
        );
      },
    );
  }
}
