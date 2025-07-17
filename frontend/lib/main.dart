import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/l10n/app_localizations.dart';
import 'package:frontend/pages/register_page.dart';
import 'package:frontend/pages/search_page.dart';
import 'package:frontend/pages/setting_page.dart';
import 'package:frontend/pages/start_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'theme.dart';
import 'util.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>()!;
    state.setLocale(newLocale);
  }

  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? locale;

  @override
  void initState() {
    super.initState();
    _loadSavedLanguage();
  }

  void setLocale(Locale newLocale) {
    setState(() {
      locale = newLocale;
    });
  }

  void _loadSavedLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedLanguageCode = prefs.getString('languageCode');
    if (savedLanguageCode != null) {
      setState(() {
        locale = Locale(savedLanguageCode);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = createTextTheme(
      context,
      "Noto Sans JP",
      "Noto Sans JP",
    );

    MaterialTheme theme = MaterialTheme(textTheme);
    return MaterialApp(
      title: 'sugomori',
      theme: theme.light(),
      initialRoute: "/start",
      routes: {
        '/start': (context) => const StartPage(),
        '/search': (context) => const SearchPage(),
        '/register': (context) => const RegisterPage(),
        '/setting': (context) => const SettingPage(),
      },
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: const [
        Locale('en'),
        Locale('ja'),
        Locale('ko'),
        Locale('zh'),
      ],
      locale: locale,
    );
  }
}
