import 'package:flutter/material.dart';
import 'package:frontend/main.dart';

class LanguageDropdown extends StatefulWidget {
  const LanguageDropdown({super.key});

  @override
  State<LanguageDropdown> createState() => _LanguageDropdownState();
}

class _LanguageDropdownState extends State<LanguageDropdown> {
  // final List<String> languages = ['ja', 'zh', 'ko', 'en'];
  void onChanged(String? newValue) {
    setState(() {
      if (newValue == null) return;
      Locale newLocale = Locale(newValue);
      MyApp.setLocale(context, newLocale);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: Localizations.localeOf(context).languageCode,
      items: const [
        DropdownMenuItem(value: 'ja', child: Text('日本語')),
        DropdownMenuItem(value: 'ko', child: Text('한국어')),
        DropdownMenuItem(value: 'zh', child: Text('中文')),
        DropdownMenuItem(value: 'en', child: Text('English')),
      ],
      onChanged: onChanged,
      underline: Container(height: 0),
    );
    // return SizedBox(
    //   height: 80,
    //   width: 150,
    //   child: CupertinoPicker(
    //     itemExtent: 32,
    //     onSelectedItemChanged: onChanged,
    //     scrollController: FixedExtentScrollController(
    //       initialItem: languages.indexOf(
    //         Localizations.localeOf(context).languageCode,
    //       ),
    //     ),
    //     children: [
    //       const Center(child: Text('日本語', style: TextStyle(fontSize: 16))),
    //       const Center(child: Text('中文', style: TextStyle(fontSize: 16))),
    //       const Center(child: Text('한국어', style: TextStyle(fontSize: 16))),
    //       const Center(child: Text('English', style: TextStyle(fontSize: 16))),
    //     ],
    //   ),
    // );
  }
}
