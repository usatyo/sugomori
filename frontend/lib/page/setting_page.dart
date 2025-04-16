import 'package:flutter/material.dart';
import 'package:frontend/components/bottom_menu.dart';
import 'package:frontend/components/general_setting.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.only(top: 50)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
            child: Text(
              "設定",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.center,
            child: GeneralSetting(),
          ),
          Expanded(child: Container()),
          BottomMenu(),
        ],
      ),
    );
  }
}
