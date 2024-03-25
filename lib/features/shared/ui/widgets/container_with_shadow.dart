import 'package:flutter/material.dart';
import 'package:journal_app/app/theme/colors.dart';
import 'package:journal_app/features/shared/services/app_mode_service.dart';
import 'package:provider/provider.dart';

class ContainerWithShadow extends StatelessWidget {
  final Widget child;
  final EdgeInsets margin;
  final EdgeInsets? padding;

  const ContainerWithShadow({
    required this.child,
    this.margin = const EdgeInsets.only(left: 16, top: 12, right: 16),
    this.padding,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool isLightMode = context.watch<AppModeService>().isLightMode;
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: isLightMode ? Colors.white : AppColors.darkGrey0,
        borderRadius: const BorderRadius.all(
          Radius.circular(16),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            offset: const Offset(0, 2),
            spreadRadius: 1,
            blurRadius: 3,
          ),
        ],
      ),
      child: child,
    );
  }
}
