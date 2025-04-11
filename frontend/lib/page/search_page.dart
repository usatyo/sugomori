import 'package:flutter/material.dart';
import 'package:frontend/components/bottom_menu.dart';
import 'package:frontend/components/goban.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              child: Goban(),
            ),
          ),
          BottomMenu(),
        ],
      ),
    );
  }
}
