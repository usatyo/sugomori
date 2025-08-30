import 'package:flutter/material.dart';
import 'package:frontend/l10n/app_localizations.dart';

class LicenseSetting extends StatelessWidget {
  const LicenseSetting({super.key});

  void onPressed(BuildContext context) {
    showLicensePage(
      context: context,
      applicationName: 'sugomori',
      applicationVersion: '1.0.0',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15),
            child: Row(
              children: [
                Text(
                  AppLocalizations.of(context)!.setting_license,
                  style: TextStyle(fontSize: 16),
                ),
                Expanded(child: SizedBox.shrink()),
                IconButton(
                  onPressed: () {
                    onPressed(context);
                  },
                  icon: Icon(Icons.arrow_right),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
