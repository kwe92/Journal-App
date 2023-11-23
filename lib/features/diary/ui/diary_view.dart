import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DiaryView extends StatelessWidget {
  const DiaryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MyDiary"),
        centerTitle: true,
        leading: SvgPicture.asset("assets/images/menu_icon.svg"),
        actions: [SvgPicture.asset("assets/images/setings_icon.svg")],
      ),
      body: const SizedBox(),
    );
  }
}
