import 'package:flutter/material.dart';

class FavoriteButton extends StatelessWidget {
  final VoidCallback onPressed;

  final double size;

  final bool isLiked;

  const FavoriteButton({
    required this.onPressed,
    required this.size,
    required this.isLiked,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        isLiked ? Icons.favorite : Icons.favorite_outline,
        size: size,
        color: Colors.red.withOpacity(0.60),
      ),
    );
  }
}
