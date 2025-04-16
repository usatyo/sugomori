import 'package:flutter/material.dart';

class GeneralSetting extends StatefulWidget {
  const GeneralSetting({super.key});

  @override
  State<GeneralSetting> createState() => _GeneralSettingState();
}

class _GeneralSettingState extends State<GeneralSetting> {
  bool isDarkMode = false;
  void onDarkModeChanged(bool value) {
    setState(() {
      isDarkMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15, right: 10),
            child: Row(
              children: [
                Text("ダークモード"),
                Expanded(child: SizedBox.shrink()),
                Switch(value: isDarkMode, onChanged: onDarkModeChanged),
              ],
            ),
          ),
          // Divider(
          //   height: 1,
          //   color: Colors.black12,
          // ),
          // Padding(
          //   padding: EdgeInsets.only(left: 15, right: 10),
          //   child: Row(
          //     children: [
          //       Text("使用言語"),
          //       Expanded(child: SizedBox.shrink()),
          //       Switch(value: true, onChanged: null),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
