import 'package:flutter/material.dart';
import 'package:journal_app/app/theme/colors.dart';

class AddButton extends StatelessWidget {
  final VoidCallback onTap;

  const AddButton({
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const double size = 64;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(
          left: 32,
          top: 32,
          right: 32,
          bottom: 56,
        ),
        width: size,
        height: size,
        decoration: const BoxDecoration(
          color: AppColors.lightGreen,
          borderRadius: BorderRadius.all(
            Radius.circular(size / 2),
          ),
        ),
        child: const Icon(
          Icons.add,
          color: AppColors.offWhite,
          size: 52,
        ),
      ),
    );
  }
}
