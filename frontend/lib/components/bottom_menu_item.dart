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
          Row(
            spacing: 6,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              selected! ? TextDecoration() : Container(),
              Text(
                label!,
                style: TextStyle(
                  fontSize: 12,
                  height: 1,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              selected! ? TextDecoration() : Container(),
            ],
          ),
        ],
      ),
    );
  }
}

class TextDecoration extends StatelessWidget {
  const TextDecoration({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.5,
      width: 6,
      color: Theme.of(context).primaryColor,
    );
  }
}
