import 'package:flutter/material.dart';
import 'package:journal_app/app/resources/reusables.dart';
import 'package:journal_app/app/theme/colors.dart';
import 'package:journal_app/features/profile/profile_settings/ui/profile_settings_view_model.dart';
import 'package:journal_app/features/shared/services/app_mode_service.dart';
import 'package:journal_app/features/shared/utilities/common_box_shadow.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class DeleteAccountListTile extends ViewModelWidget<ProfileSettingsViewModel> {
  const DeleteAccountListTile({super.key});

  @override
  Widget build(BuildContext context, ProfileSettingsViewModel viewModel) {
    return GestureDetector(
      onTap: () async => await viewModel.deleteAccountPopupMenu(context),
      child: Container(
        height: 90,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: context.watch<AppModeService>().isLightMode ? AppColors.offWhite : AppColors.darkGrey0,
          borderRadius: const BorderRadius.all(
            Radius.circular(16),
          ),
          boxShadow: const [CommonBoxShadow()],
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Delete Account',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                gap4,
                Text(
                  'Delete this account and all associated data.',
                  style: TextStyle(
                    fontSize: 10,
                    color: context.watch<AppModeService>().isLightMode ? AppColors.offGrey.withOpacity(0.85) : Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
