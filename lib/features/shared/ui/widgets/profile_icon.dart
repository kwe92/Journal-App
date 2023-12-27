import 'package:flutter/material.dart';
import 'package:journal_app/app/theme/colors.dart';

class ProfileIcon extends StatelessWidget {
  final String userFirstName;
  final VoidCallback? onPressed;
  final Color? color;

  const ProfileIcon({
    required this.userFirstName,
    this.onPressed,
    this.color,
    super.key,
  });

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
            userFirstName.substring(0, 1).toUpperCase(),
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
