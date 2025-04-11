import 'package:flutter/material.dart';
import 'package:frontend/components/bottom_menu.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: FilledButton(onPressed: () {}, child: Text("ボタン")),
            ),
          ),
          BottomMenu(),
        ],
      ),
    );
  }
}
