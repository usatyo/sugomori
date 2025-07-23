import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/l10n/app_localizations.dart';
import 'package:frontend/providers/page_index_provider.dart';

class BottomMenu extends ConsumerWidget {
  const BottomMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int currentIndex = ref.watch(pageIndexNotifierProvider);

    return BottomNavigationBar(
      currentIndex: currentIndex,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.find_in_page, size: 40),
          label: AppLocalizations.of(context)!.menu_search,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.note_add, size: 40),
          label: AppLocalizations.of(context)!.menu_register,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings, size: 40),
          label: AppLocalizations.of(context)!.menu_setting,
        ),
      ],
      onTap:
          (index) => {
            ref.read(pageIndexNotifierProvider.notifier).update(index),
          },
    );
  }
}
