import 'package:flutter/material.dart';
import 'package:journal_app/app/theme/colors.dart';

class CenteredLoader extends StatelessWidget {
  final Color color;
  const CenteredLoader({this.color = AppColors.lightGreen, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(color: color),
    );
  }
}
