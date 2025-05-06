import 'package:flutter/material.dart';
import 'package:frontend/services/joseki_api_service.dart';

class GeneralSetting extends StatefulWidget {
  const GeneralSetting({super.key});

  @override
  State<GeneralSetting> createState() => _GeneralSettingState();
}

class _GeneralSettingState extends State<GeneralSetting> {
  bool isDarkMode = false;
  JosekiApiService josekiApiService = JosekiApiService.instance;
  String message = "";

  void onDarkModeChanged(bool value) {
    setState(() {
      isDarkMode = value;
      josekiApiService.fetchPong().then((value) {
        setState(() {
          message = value;
        });
      });
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
                Switch(
                  value: isDarkMode,
                  onChanged: onDarkModeChanged,
                  trackOutlineWidth: WidgetStatePropertyAll(0),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: Colors.black12),
          Padding(
            padding: EdgeInsets.only(left: 15, right: 10),
            child: Row(
              children: [
                Text(message),
                Expanded(child: SizedBox.shrink()),
                Switch(value: true, onChanged: null),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
