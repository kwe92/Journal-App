import 'package:flutter/material.dart';
import 'package:journal_app/app/theme/colors.dart';
import 'package:journal_app/features/profile/profile_settings/ui/widgets/delete_account_list_tile.dart';
import 'package:journal_app/features/shared/services/app_mode_service.dart';
import 'package:journal_app/features/shared/utilities/common_box_shadow.dart';
import 'package:provider/provider.dart';

class DeleteProfileSection extends StatelessWidget {
  const DeleteProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: double.maxFinite,
      decoration: BoxDecoration(
        // color: Colors.white,
        color: context.watch<AppModeService>().isLightMode ? Colors.white : AppColors.darkGrey0,
        borderRadius: const BorderRadius.all(
          Radius.circular(16),
        ),
        boxShadow: const [CommonBoxShadow()],
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
