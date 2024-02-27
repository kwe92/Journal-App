import 'package:flutter/material.dart';
import 'package:journal_app/app/resources/reusables.dart';
import 'package:journal_app/app/theme/colors.dart';
import 'package:journal_app/features/quotes/likedQuotes/ui/liked_quotes_view_model.dart';
import 'package:journal_app/features/quotes/shared/utils/functions.dart';
import 'package:journal_app/features/quotes/shared/widgets/favorite_button.dart';
import 'package:journal_app/features/quotes/shared/widgets/share_button.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:journal_app/features/shared/utilities/common_box_shadow.dart';
import 'package:stacked/stacked.dart';

class LikedQuoteCard extends ViewModelWidget<LikedQuotesViewModel> {
  final int index;

  const LikedQuoteCard({required this.index, super.key});

  @override
  Widget build(BuildContext context, LikedQuotesViewModel viewModel) {
    final smallDevice = deviceSizeService.smallDevice;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      margin: EdgeInsets.only(
        left: 24,
        top: !(index == 0) ? 24 : 0,
        right: 24,
        bottom: viewModel.likedQuotes.length - 1 == index ? 24 : 0,
      ),
      decoration: const BoxDecoration(
        color: AppColors.darkGrey0,
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
        boxShadow: [CommonBoxShadow()],
      ),
      child: Column(
        children: [
          Text(
            viewModel.likedQuotes[index].quote,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: !smallDevice ? 24 : 20,
              color: Colors.white,
            ),
          ),
          !smallDevice ? gap24 : gap4,
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ShareButton(
                size: 26.0,
                contentToShare: shareQuote(viewModel.likedQuotes[index]),
              ),
              Expanded(
                child: Text(
                  viewModel.likedQuotes[index].author,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: !smallDevice ? 16 : 14,
                    fontWeight: !smallDevice ? FontWeight.w800 : FontWeight.w700,
                  ),
                ),
              ),
              FavoriteButton(
                onPressed: () => viewModel.removeLikedQuote(viewModel.likedQuotes[index]),
                size: 26,
                isLiked: viewModel.likedQuotes[index].isLiked,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
