import 'package:flutter/material.dart';
import 'package:journal_app/app/theme/colors.dart';

class AddButton extends StatelessWidget {
  // final VoidCallback onTap;
  final double size;

  const AddButton({
    // required this.onTap,
    required this.size,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.mainThemeColor,
        borderRadius: BorderRadius.all(
          Radius.circular(size / 2),
        ),
      ),
      child: const Icon(
        Icons.add,
        color: AppColors.offWhite,
        size: 52,
      ),
    );
  }
}
