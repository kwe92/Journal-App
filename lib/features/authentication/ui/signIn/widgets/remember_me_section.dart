import 'package:flutter/material.dart';
import 'package:journal_app/app/resources/reusables.dart';
import 'package:journal_app/app/theme/colors.dart';
import 'package:journal_app/app/theme/theme.dart';
import 'package:journal_app/features/authentication/ui/signIn/signin_view_model.dart';
import 'package:stacked/stacked.dart';

class RememberMeSection extends ViewModelWidget<SignInViewModel> {
  const RememberMeSection({super.key});

  @override
  Widget build(BuildContext context, SignInViewModel viewModel) {
    return Row(
      children: [
        SizedBox(
          width: 42,
          child: Transform.scale(
            scale: 0.7,
            child: Switch.adaptive(
              activeTrackColor: AppColors.mainThemeColor,
              trackOutlineColor: resolver((states) => AppColors.mainThemeColor),
              value: viewModel.isRemeberMeSwitchedOn,
              onChanged: viewModel.setRemember,
            ),
          ),
        ),
        gap6,
        const Text(
          "Remember",
          style: TextStyle(
            fontSize: 14,
            color: AppColors.mainThemeColor,
          ),
        ),
      ],
    );
  }
}
