import 'package:flutter/material.dart';
import 'package:frontend/l10n/app_localizations.dart';
import 'package:frontend/main.dart';
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
      josekiApiService.fetchHello().then((value) {
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
                Text(AppLocalizations.of(context)!.setting_language),
                Expanded(child: SizedBox.shrink()),
                DropdownButton<String>(
                  value: Localizations.localeOf(context).languageCode,
                  items: const [
                    DropdownMenuItem(value: 'en', child: Text('English')),
                    DropdownMenuItem(value: 'ja', child: Text('日本語')),
                  ],
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        Locale newLocale = Locale(newValue);
                        MyApp.setLocale(context, newLocale);
                      });
                    }
                  },
                ),
              ],
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.only(left: 15, right: 10),
          //   child: Row(
          //     children: [
          //       Text("ダークモード"),
          //       Expanded(child: SizedBox.shrink()),
          //       Switch(
          //         value: isDarkMode,
          //         onChanged: onDarkModeChanged,
          //         trackOutlineWidth: WidgetStatePropertyAll(0),
          //       ),
          //     ],
          //   ),
          // ),
          // Divider(height: 1, color: Colors.black12),
          // Padding(
          //   padding: EdgeInsets.only(left: 15, right: 10),
          //   child: Row(
          //     children: [
          //       Text(message),
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
