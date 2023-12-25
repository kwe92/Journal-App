import 'package:flutter/material.dart';
import 'package:journal_app/app/theme/colors.dart';
import 'package:journal_app/features/authentication/models/user.dart';
import 'package:journal_app/features/shared/services/services.dart';

class ProfileIcon extends StatelessWidget {
  final VoidCallback onPressed;
  final Color? color;

  ProfileIcon({
    required this.onPressed,
    this.color,
    super.key,
  });

// TODO: Not Updating Properly
  final User user = userService.currentUser!;

  @override
  Widget build(BuildContext context) {
    const double side = 30;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: side,
        height: side,
        decoration: BoxDecoration(
          color: color ?? AppColors.lightGreen,
          borderRadius: const BorderRadius.all(
            Radius.circular(side / 2),
          ),
        ),
        child: Center(
          child: Text(
            user.firstName?.substring(0, 1).toUpperCase() ?? 'P',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
