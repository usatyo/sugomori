// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get menu_search => '定石検索';

  @override
  String get menu_register => '定石登録';

  @override
  String get menu_setting => '設定';

  @override
  String get title_setting => '設定';

  @override
  String get button_search => '検索';

  @override
  String get button_register => '登録';

  @override
  String get button_start => '始める';

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
