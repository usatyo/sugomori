import 'package:flutter/material.dart';
import 'package:frontend/l10n/app_localizations.dart';
import 'package:frontend/main.dart';

class LanguageSetting extends StatefulWidget {
  const LanguageSetting({super.key});

  @override
  State<LanguageSetting> createState() => _LanguageSettingState();
}

class _LanguageSettingState extends State<LanguageSetting> {
  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
