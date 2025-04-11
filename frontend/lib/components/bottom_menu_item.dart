import 'package:flutter/material.dart';

class BottomMenuItem extends StatelessWidget {
  const BottomMenuItem({
    super.key,
    this.label,
    this.icon,
    this.route,
    this.selected,
  });
  final String? label;
  final IconData? icon;
  final String? route;
  final bool? selected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (route != null && ModalRoute.of(context)?.settings.name != route) {
          Navigator.pushNamed(context, route!);
        }
      },
      child: Column(
        children: [
          Opacity(
            opacity: selected! ? 1 : 0.5,
            child: Icon(icon, size: 40, color: Theme.of(context).primaryColor),
          ),
          Text(
            label!,
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
