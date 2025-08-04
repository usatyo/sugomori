import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/l10n/app_localizations.dart';
import 'package:frontend/page_navigator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'theme.dart';
import 'util.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
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

    return ScreenUtilInit(
      // iPhone 16 Pro Size
      designSize: const Size(402, 874),
      minTextAdapt: true,
      splitScreenMode: true,
      builder:
          (_, _) => MaterialApp(
            title: 'sugomori',
            theme: theme.light(),
            home: const PageNavigator(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: const [
              Locale('en'),
              Locale('ja'),
              Locale('ko'),
              Locale('zh'),
            ],
            locale: locale,
          ),
    );
  }
}

extension BuildContextExtension on BuildContext {
  bool isTablet() {
    const tabletWidth = 600;
    //  縦の場合は横幅で、横の場合は高さでタブレットか判定する
    return MediaQuery.orientationOf(this) == Orientation.portrait
        ? MediaQuery.sizeOf(this).width > tabletWidth
        : MediaQuery.sizeOf(this).height > tabletWidth;
  }
}

