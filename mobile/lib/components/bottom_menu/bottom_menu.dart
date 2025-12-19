import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/l10n/app_localizations.dart';
import 'package:frontend/main.dart';
import 'package:frontend/providers/page_index_provider.dart';

class BottomMenu extends ConsumerWidget {
  const BottomMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int currentIndex = ref.watch(pageIndexNotifierProvider);
    final double iconSize = context.isTablet() ? 56 : 40;
    final double selectedFontSize = context.isTablet() ? 18 : 14;
    final double unselectedFontSize = context.isTablet() ? 16 : 12;

    return BottomNavigationBar(
      iconSize: iconSize,
      selectedFontSize: selectedFontSize,
      unselectedFontSize: unselectedFontSize,
      currentIndex: currentIndex,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.find_in_page),
          label: AppLocalizations.of(context)!.menu_search,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.note_add),
          label: AppLocalizations.of(context)!.menu_register,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: AppLocalizations.of(context)!.menu_setting,
        ),
      ],
      onTap: (index) {
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
        ref.read(pageIndexNotifierProvider.notifier).update(index);
      },
    );
  }
}
