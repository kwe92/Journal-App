import 'package:flutter/material.dart';
import 'package:journal_app/app/theme/colors.dart';

class CommonBoxShadow extends BoxShadow {
  const CommonBoxShadow();

  @override
  Offset get offset => const Offset(0, 2);

  @override
  Color get color => AppColors.shadowColor;

  @override
  double get blurRadius => 3;

  @override
  double get spreadRadius => 1;
}
