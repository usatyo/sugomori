import 'package:flutter/material.dart';
import 'package:frontend/components/setting/contact_setting.dart';
import 'package:frontend/components/setting/general_setting.dart';
import 'package:frontend/components/setting/license_setting.dart';
import 'package:frontend/l10n/app_localizations.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(padding: EdgeInsets.only(top: 50)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
          child: Text(
            AppLocalizations.of(context)!.title_setting,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          alignment: Alignment.center,
          child: GeneralSetting(),
        ),
        Container(
          padding: EdgeInsets.all(10),
          alignment: Alignment.center,
          child: LicenseSetting(),
        ),
        Container(
          padding: EdgeInsets.all(10),
          alignment: Alignment.center,
          child: ContactSetting(),
        ),
        Expanded(child: Container()),
      ],
    );
  }
}
