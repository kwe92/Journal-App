import 'package:flutter/material.dart';
import 'package:journal_app/app/general/constants.dart';
import 'package:journal_app/app/theme/colors.dart';
import 'package:journal_app/features/quotes/likedQuotes/ui/liked_quotes_view_model.dart';
import 'package:journal_app/features/quotes/likedQuotes/ui/widgets/liked_quotes_filter_button_controller.dart';
import 'package:journal_app/features/quotes/shared/models/liked_quote.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class LikedQuotesFilterButton extends ViewModelWidget<LikedQuotesViewModel> {
  final List<LikedQuote> likedQuotes;

  const LikedQuotesFilterButton({required this.likedQuotes, super.key});

  @override
  Widget build(context, viewModel) {
    return ChangeNotifierProvider(
      create: (context) => LikedQuotesFilterButtonController(),
      builder: (context, child) {
        final controller = context.watch<LikedQuotesFilterButtonController>();

        viewModel.modelQuery.addListener(() => controller.setDropdownValue(viewModel.modelQuery.value));

        return DropdownButton<String>(
          menuMaxHeight: MediaQuery.of(context).size.height / 1.275,
          value: controller.dropdownValue,
          icon: const Icon(Icons.arrow_drop_down),
          elevation: 16,
          style: TextStyle(color: AppColors.lotusColor),
          underline: Container(
            height: 2,
            color: AppColors.lotusColor,
          ),
          onChanged: (value) => viewModel.setFilteredLikedQuotes(value ?? QuoteAuthorFilterOptions.all.name),
          items: <DropdownMenuItem<String>>[
            ...controller.dropdownOptions.map<DropdownMenuItem<String>>(
              (value) => DropdownMenuItem<String>(
                value: value,
                child: FittedBox(
                  child: Text(value),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
