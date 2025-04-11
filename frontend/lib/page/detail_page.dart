import 'package:flutter/material.dart';
import 'package:frontend/components/bottom_menu.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              child: FilledButton(onPressed: () {}, child: Text("aa")),
            ),
          ),
          BottomMenu(),
        ],
      ),
    );
  }
}
