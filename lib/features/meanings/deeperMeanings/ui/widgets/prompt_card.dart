import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:journal_app/app/theme/colors.dart';
import 'package:journal_app/features/shared/services/app_mode_service.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:journal_app/features/shared/utilities/common_box_shadow.dart';
import 'package:provider/provider.dart';

class PromptCard extends StatelessWidget {
  final String promptText;
  final VoidCallback onTap;
  const PromptCard({
    required this.onTap,
    required this.promptText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final smallDevice = deviceSizeService.smallDevice;

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: context.watch<AppModeService>().isLightMode ? Colors.white : AppColors.darkGrey0,
              borderRadius: const BorderRadius.all(
                Radius.circular(16),
              ),
              boxShadow: const [CommonBoxShadow()],
            ),
            child: SvgPicture.asset(
              "assets/images/lotus-flower-bloom.svg",
              color: AppColors.lotusColor,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 6, bottom: !smallDevice ? 16 : 12, right: 6),
                  child: Text(
                    promptText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: !smallDevice ? 18 : 14,
                      fontWeight: !smallDevice ? FontWeight.w800 : FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


//  Container(
//         decoration: BoxDecoration(
//           borderRadius: const BorderRadius.all(
//             Radius.circular(16),
//           ),
//           image: DecorationImage(
//             image: Image.asset("/Users/kwe/WorkingWithGemini/working_with_gemini/assets/compassion.avif").image,
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(left: 6, bottom: 8, right: 6),
//               child: Text(
//                 promptText,
//                 textAlign: TextAlign.center,
//                 style: const TextStyle(
//                   // color: Colors.purple,
//                   fontSize: 18,
//                   fontWeight: FontWeight.w800,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),