import 'package:flutter/material.dart';
import 'package:frontend/components/bottom_menu.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              child: FilledButton(onPressed: () {}, child: Text("bb")),
            ),
          ),
          BottomMenu(),
        ],
      ),
    );
  }
}
