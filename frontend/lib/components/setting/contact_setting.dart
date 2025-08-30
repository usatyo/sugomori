import 'package:flutter/material.dart';
import 'package:frontend/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSetting extends StatelessWidget {
  const ContactSetting({super.key});

  void onPressed(BuildContext context) {
    launchUrl(Uri.parse('https://forms.gle/LXvu8gmzaxLaPndp7/'));
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
                  AppLocalizations.of(context)!.setting_contact,
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
