import 'package:flutter/material.dart';
import 'package:frontend/main.dart';

class IconText extends StatelessWidget {
  const IconText({
    super.key,
    required this.hintText,
    required this.icon,
    this.onPressed,
  });
  final String hintText;
  final IconData icon;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final double iconSize = context.isTablet() ? 28 : 20;
    final double fontSize = context.isTablet() ? 14 : 10;
    final double spacing = context.isTablet() ? 5 : 0;
    final double padding = context.isTablet() ? 12 : 0;

    return FittedBox(
      fit: BoxFit.fill,
      child: Column(
        spacing: spacing,
        children: [
          IconButton.filled(
            padding: EdgeInsets.all(padding),
            onPressed: onPressed,
            icon: Icon(icon, size: iconSize),
          ),
          Text(hintText, style: TextStyle(fontSize: fontSize)),
        ],
      ),
    );
  }
}
