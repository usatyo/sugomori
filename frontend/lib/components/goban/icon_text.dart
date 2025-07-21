import 'package:flutter/material.dart';

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
    return FittedBox(
      fit: BoxFit.fill,
      child: Column(
        children: [
          IconButton.filled(onPressed: onPressed, icon: Icon(icon, size: 20)),
          Text(hintText, style: TextStyle(fontSize: 10)),
        ],
      ),
    );
  }
}
