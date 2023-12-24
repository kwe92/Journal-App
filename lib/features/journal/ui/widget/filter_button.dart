import 'package:flutter/material.dart';
import 'package:journal_app/app/theme/colors.dart';
import 'package:journal_app/features/journal/ui/journal_view_model.dart';
import 'package:journal_app/features/journal/ui/widget/filter_button_model.dart';
import 'package:stacked/stacked.dart';

class FilterButton extends ViewModelWidget<JournalViewModel> {
  const FilterButton({super.key});

  @override
  Widget build(BuildContext context, JournalViewModel viewModel) {
    const Color lightGreen = AppColors.lightGreen;

    return ViewModelBuilder<FilterButtonModel>.reactive(
      viewModelBuilder: () => FilterButtonModel(),
      builder: (context, FilterButtonModel model, _) => DropdownButton<String>(
        value: model.dropdownValue,
        icon: const Icon(Icons.arrow_drop_down),
        elevation: 16,
        style: const TextStyle(color: lightGreen),
        underline: Container(
          height: 2,
          color: lightGreen,
        ),
        onChanged: (String? value) {
          model.setDropdownValue(value!);
          viewModel.setFilteredJournalEntries(value);
        },
        items: <DropdownMenuItem<String>>[
          ...FilterButtonModel.dropdownOptions.map<DropdownMenuItem<String>>(
            (String value) => DropdownMenuItem<String>(
              value: value,
              child: FittedBox(
                child: Text(value),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
