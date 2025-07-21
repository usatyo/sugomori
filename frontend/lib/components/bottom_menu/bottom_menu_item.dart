import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/providers/provider.dart';

class BottomMenuItem extends ConsumerWidget {
  const BottomMenuItem({
    super.key,
    required this.label,
    required this.icon,
    required this.route,
    required this.selected,
  });
  final String label;
  final IconData icon;
  final String route;
  final bool selected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        if (ModalRoute.of(context)?.settings.name != route) {
          ref.read(gobanStateNotifierProvider.notifier).resetGoban();
          Navigator.pushNamed(context, route);
        }
      },
      child: Column(
        children: [
          Opacity(
            opacity: selected ? 1 : 0.5,
            child: Icon(icon, size: 40, color: Theme.of(context).primaryColor),
          ),
          Row(
            spacing: 6,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              selected ? TextDecoration() : Container(),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  height: 1,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              selected ? TextDecoration() : Container(),
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
