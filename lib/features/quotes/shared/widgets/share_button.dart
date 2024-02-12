import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ShareButton extends StatelessWidget {
  final String contentToShare;
  final double size;
  const ShareButton({
    required this.size,
    required this.contentToShare,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async => await Share.share(contentToShare),
      icon: Icon(
        Icons.ios_share,
        size: size,
        color: Colors.blue.withOpacity(0.60),
      ),
    );
  }
}
