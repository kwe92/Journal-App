import 'package:auto_route/annotations.dart';
import 'package:entry/entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:journal_app/app/theme/colors.dart';
import 'package:journal_app/features/quotes/likedQuotes/ui/liked_quotes_view_model.dart';
import 'package:journal_app/features/quotes/likedQuotes/ui/widgets/liked_quote_card.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:journal_app/features/shared/ui/widgets/centered_loader.dart';
import 'package:stacked/stacked.dart';

@RoutePage()
class LikedQuotesView extends StatelessWidget {
  const LikedQuotesView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => LikedQuotesViewModel(),
      builder: (context, viewModel, _) {
        return Scaffold(
          backgroundColor: theme.colorScheme.surface,
          appBar: viewModel.likedQuotes.isNotEmpty
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
          body: viewModel.likedQuotes.isEmpty && !viewModel.isBusy
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
                            color: AppColors.lotusColor,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : !viewModel.isBusy
                  ? ListView.builder(
                      itemCount: viewModel.likedQuotes.length,
                      itemBuilder: (context, index) => LikedQuoteCard(index: index),
                    )
                  : const CenteredLoader(),
        );
      },
    );
  }
}
