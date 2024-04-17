import 'package:flutter/material.dart';
import 'package:journal_app/features/journal/ui/journal_view_model_v2.dart';
import 'package:stacked/stacked.dart';

class HideableSearchBar extends ViewModelWidget<JournalViewModelV2> {
  final TextEditingController searchController;
  final FocusNode searchNode;

  const HideableSearchBar({
    required this.searchController,
    required this.searchNode,
    super.key,
  });

  @override
  Widget build(BuildContext context, JournalViewModelV2 viewModel) {
    return SliverAppBar(
      toolbarHeight: 65,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      // floating: required to make SliverAppBar snappable
      floating: true,
      // snap: required to make SliverAppBar snappable
      snap: true,
      backgroundColor: Theme.of(context).colorScheme.background,

      title: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        // SEARCH BAR
        child: TextField(
          focusNode: searchNode,
          controller: searchController,
          onChanged: viewModel.onQueryItems,
          decoration: InputDecoration(
            labelText: 'Search',
            hintText: 'Search',
            prefixIcon: const Icon(Icons.search_outlined),
            suffixIcon: viewModel.query.isNotEmpty
                ? IconButton(
                    onPressed: () {
                      searchController.clear();
                      viewModel.clearQueryFromFilteredEntries();
                    },
                    icon: const Icon(Icons.clear),
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
