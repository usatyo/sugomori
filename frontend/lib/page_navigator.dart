import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/components/bottom_menu/bottom_menu.dart';
import 'package:frontend/pages/register_page.dart';
import 'package:frontend/pages/search_page.dart';
import 'package:frontend/pages/setting_page.dart';
import 'package:frontend/providers/page_index_provider.dart';

class PageNavigator extends ConsumerWidget {
  const PageNavigator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: IndexedStack(
        index: ref.watch(pageIndexNotifierProvider),
        children: [SearchPage(), RegisterPage(), SettingPage()],
      ),
      bottomNavigationBar: BottomMenu(),
    );
  }
}
