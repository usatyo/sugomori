import 'package:flutter/material.dart';
import 'package:frontend/page/detail_page.dart';
import 'package:frontend/page/register_page.dart';
import 'package:frontend/page/setting_page.dart';

import 'page/search_page.dart';
import 'theme.dart';
import 'util.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;
    TextTheme textTheme = createTextTheme(
      context,
      "Noto Sans JP",
      "Noto Sans JP",
    );

    MaterialTheme theme = MaterialTheme(textTheme);
    return MaterialApp(
      title: 'sugomori',
      theme: brightness == Brightness.light ? theme.light() : theme.dark(),
      initialRoute: "/search",
      routes: {
        '/search': (context) => const SearchPage(),
        '/detail' : (context) => const DetailPage(),
        '/register': (context) => const RegisterPage(),
        '/setting': (context) => const SettingPage(),
      },
    );
  }
}
