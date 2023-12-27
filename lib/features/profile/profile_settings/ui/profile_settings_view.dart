// ignore_for_file: unused_element

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:journal_app/app/resources/reusables.dart';
import 'package:journal_app/features/profile/profile_settings/ui/profile_settings_view_model.dart';
import 'package:journal_app/features/profile/profile_settings/ui/widgets/delete_profile_section.dart';
import 'package:journal_app/features/profile/profile_settings/ui/widgets/edit_profile_list_tile.dart';
import 'package:journal_app/features/shared/ui/base_scaffold.dart';
import 'package:journal_app/features/shared/ui/widgets/profile_icon.dart';
import 'package:stacked/stacked.dart';

@RoutePage()
class ProfileSettingsView extends StatelessWidget {
  const ProfileSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileSettingsViewModel>.reactive(
      viewModelBuilder: () => ProfileSettingsViewModel(),
      builder: (BuildContext context, ProfileSettingsViewModel model, _) {
        return SafeArea(
          child: BaseScaffold(
            title: 'Profile',
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: ProfileIcon(
                  userFirstName: model.currentUser?.firstName ?? "P",
                ),
              ),
            ],
            body: Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 18, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _SectionHeader(headerText: 'Edit Profile'),
                  gap16,
                  EditProfileListTile(
                    userFullName: model.userFullName,
                    userEmail: model.userEmail,
                  ),
                  gap28,
                  const _SectionHeader(headerText: 'Delete Profile'),
                  gap16,
                  const DeleteProfileSection(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String headerText;
  const _SectionHeader({required this.headerText, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      headerText,
      style: const TextStyle(fontWeight: FontWeight.w700),
    );
  }
}
