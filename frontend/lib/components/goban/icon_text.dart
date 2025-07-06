import 'package:flutter/material.dart';

class IconText extends StatelessWidget {
  const IconText({
    super.key,
    required this.hintText,
    required this.icon,
    required this.onPressed,
  });
  final String hintText;
  final IconData icon;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton.filled(onPressed: onPressed, icon: Icon(icon, size: 20)),
        Text(hintText, style: TextStyle(fontSize: 10)),
      ],
    );
  }
}
