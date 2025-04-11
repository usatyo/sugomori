import 'package:flutter/material.dart';

class BottomMenuItem extends StatelessWidget {
  const BottomMenuItem({super.key, this.label, this.icon, this.selected});
  final String? label;
  final IconData? icon;
  final bool? selected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Opacity(
          opacity: selected! ? 1 : 0.5,
          child: Icon(icon, size: 40, color: Theme.of(context).primaryColor),
        ),
        Text(
          label!,
          style: TextStyle(fontSize: 12, color: Theme.of(context).primaryColor),
        ),
      ],
    );
  }
}
