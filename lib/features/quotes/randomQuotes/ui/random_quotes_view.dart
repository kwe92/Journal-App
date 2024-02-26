import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:journal_app/app/resources/reusables.dart';
import 'package:journal_app/app/theme/colors.dart';
import 'package:journal_app/features/quotes/randomQuotes/ui/random_quotes_view_model.dart';
import 'package:journal_app/features/quotes/shared/utils/functions.dart';
import 'package:journal_app/features/quotes/shared/widgets/favorite_button.dart';
import 'package:journal_app/features/quotes/shared/widgets/share_button.dart';
import 'package:provider/provider.dart';

const style = TextStyle(
  color: Colors.white,
  fontSize: 26,
);

@RoutePage()
class RandomQuotesView extends StatelessWidget {
  const RandomQuotesView({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<RandomQuotesViewModel>();
    return model.isBusy
        ? circleLoader
        : PageView.builder(
            scrollDirection: Axis.vertical,
            itemCount: model.quotes.length,
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  Center(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height / 2,
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Transform.scale(
                              scaleY: 1.325,
                              scaleX: 1.0625,
                              child: SvgPicture.asset(
                                "assets/images/quotes-background-image.svg",
                                color: AppColors.darkGrey0,
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 32),
                                child: Align(
                                  child: Text(
                                    model.quotes[index].quote,
                                    style: style.copyWith(color: Colors.white.withOpacity(0.90)),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 18),
                              Align(
                                child: Text(
                                  "- ${model.quotes[index].author}",
                                  style: style.copyWith(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 42),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ShareButton(
                              size: 52.0,
                              contentToShare: shareQuote(model.quotes[index]),
                            ),
                            FavoriteButton(
                              onPressed: () => model.setLikedForQuote(model.quotes[index]),
                              size: 52,
                              isLiked: model.quotes[index].isLiked,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
  }
}
