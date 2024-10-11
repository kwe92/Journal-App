import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:journal_app/app/general/constants.dart';
import 'package:journal_app/app/resources/reusables.dart';
import 'package:journal_app/app/theme/colors.dart';
import 'package:journal_app/features/quotes/randomQuotes/ui/random_quotes_view_model.dart';
import 'package:journal_app/features/quotes/shared/utils/functions.dart';
import 'package:journal_app/features/quotes/shared/widgets/share_button.dart';
import 'package:journal_app/features/shared/services/app_mode_service.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

@RoutePage()
class RandomQuotesView extends StatelessWidget {
  const RandomQuotesView({super.key});

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(fontSize: 24, fontFamily: FontFamily.playwrite.name);

    final viewModel = context.watch<RandomQuotesViewModel>();

    final smallDevice = deviceSizeService.smallDevice;

    return viewModel.isBusy
        ? circleLoader
        : PageView.builder(
            scrollDirection: Axis.vertical,
            itemCount: viewModel.quotes.length,
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  Center(
                    child: Stack(
                      children: [
                        Positioned.fill(
                          // scales child (inthis case an image) along the 2D plane
                          child: Transform.scale(
                            scaleY: 1.325,
                            scaleX: 1.0625,
                            child: SvgPicture.asset(
                              "assets/images/quotes-background-image.svg",
                              color: AppColors.darkGrey0.withOpacity(context.read<AppModeService>().isLightMode ? 0.15 : 1),
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
                                  viewModel.quotes[index].quote,
                                  style: style,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            !smallDevice ? gap18 : gap12,
                            Align(
                              child: Text(
                                "- ${viewModel.quotes[index].author}",
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
                  Padding(
                    padding: EdgeInsets.only(bottom: !smallDevice ? 42 : 12),
                    child: Align(
                      // align child to bottom instead of guessing with random spaces
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ShareButton(
                              size: 52.0,
                              contentToShare: shareQuote(viewModel.quotes[index]),
                            ),
                            GestureDetector(
                              //!! TODO: disable button while favorite button animation is running
                              onTap: () async {
                                await viewModel.setLikedForQuote(viewModel.quotes[index]);
                              },
                              child: SizedBox(
                                width: 52.0,
                                height: 52.0,
                                child: Transform.scale(
                                  scale: 5.25,
                                  child: Rive(artboard: viewModel.riveArtBoard ?? RuntimeArtboard().artboard),
                                ),
                              ),
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
