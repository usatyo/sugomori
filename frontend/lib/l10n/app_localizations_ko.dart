// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get menu_search => '검색';

  @override
  String get menu_register => '등록';

  @override
  String get menu_setting => '설정';

  @override
  String get title_setting => '설정';

  @override
  String get button_search => '검색';

  @override
  String get button_register => '등록';

  @override
  String get button_start => '시작하기';

  @override
  String get goban_back => '1手戻る';

  @override
  String get goban_back5 => '5手戻る';

  @override
  String get goban_pass => '手抜き';

  @override
  String get goban_clear => 'クリア';

  @override
  String get setting_language => '言語';

  @override
  String get message_video_not_found => '動画が見つかりませんでした';
}
