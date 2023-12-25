import 'package:flutter/material.dart';
import 'package:journal_app/app/resources/reusables.dart';
import 'package:journal_app/app/theme/colors.dart';
import 'package:journal_app/features/profile/profile_settings/ui/profile_settings_view_model.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:journal_app/features/shared/utilities/common_box_shadow.dart';
import 'package:journal_app/features/shared/utilities/popup_parameters.dart';
import 'package:stacked/stacked.dart';

class DeleteProfileSection extends StatelessWidget {
  const DeleteProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: double.maxFinite,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
        boxShadow: [CommonBoxShadow()],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(16),
        ),
        child: ColoredBox(
          color: AppColors.orange0.withOpacity(0.15),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 24, top: 16),
                child: Text(
                  "Danger Zone",
                  style: TextStyle(
                    color: AppColors.orange0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8, right: 8, bottom: 8),
                child: DeleteAccountListTile(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DeleteAccountListTile extends ViewModelWidget<ProfileSettingsViewModel> {
  const DeleteAccountListTile({super.key});

  @override
  Widget build(BuildContext context, ProfileSettingsViewModel viewModel) {
    return GestureDetector(
      onTap: () async {
        await toastService.deleteAccountPopupMenu<bool>(
          context,
          parameters: const PopupMenuParameters(
            title: 'Permanantly delete account?',
            content: 'ALL account information will be removed from our system without recovery.',
            defaultResult: false,
            options: {
              "Delete": true,
              "Cancel": false,
            },
          ),
        );
      },
      child: Container(
        height: 90,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: const BoxDecoration(
          // color: Colors.white,
          color: AppColors.offWhite,
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
          boxShadow: [CommonBoxShadow()],
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
                    color: AppColors.offGrey.withOpacity(0.85),
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
