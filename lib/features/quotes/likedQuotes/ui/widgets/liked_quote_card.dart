import 'package:flutter/material.dart';
import 'package:journal_app/app/theme/colors.dart';
import 'package:journal_app/features/quotes/likedQuotes/ui/liked_quotes_view_model.dart';
import 'package:journal_app/features/quotes/shared/utils/functions.dart';
import 'package:journal_app/features/quotes/shared/widgets/favorite_button.dart';
import 'package:journal_app/features/quotes/shared/widgets/share_button.dart';
import 'package:journal_app/features/shared/utilities/common_box_shadow.dart';
import 'package:stacked/stacked.dart';

class LikedQuoteCard extends ViewModelWidget<LikedQuotesViewModel> {
  final int index;

  const LikedQuoteCard({required this.index, super.key});

  @override
  Widget build(BuildContext context, LikedQuotesViewModel viewModel) {
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
            style: const TextStyle(
              fontSize: 24,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ShareButton(
                size: 26.0,
                contentToShare: shareQuote(viewModel.likedQuotes[index]),
              ),
              Text(
                viewModel.likedQuotes[index].author,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
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
