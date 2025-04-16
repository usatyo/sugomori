import 'package:flutter/material.dart';
import 'package:frontend/page/register_page.dart';
import 'package:frontend/page/search_page.dart';
import 'package:frontend/page/setting_page.dart';

import 'theme.dart';
import 'util.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      initialRoute: "/search",
      routes: {
        '/search': (context) => const SearchPage(),
        '/register': (context) => const RegisterPage(),
        '/setting': (context) => const SettingPage(),
      },
    );
  }
}
