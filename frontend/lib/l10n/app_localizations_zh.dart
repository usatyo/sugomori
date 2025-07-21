// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get menu_search => '手順検索';

  @override
  String get menu_register => '手順登録';

  @override
  String get menu_setting => '設定';

  @override
  String get title_setting => '設定';

  @override
  String get button_search => '検索';

  @override
  String get button_start => '始める';

  @override
  String get button_delete => '削除';

  @override
  String get label_keyword => '検索キーワード';

  @override
  String get button_new => '新規';

  @override
  String get button_add => '追加';

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

  @override
  String get message_joseki_not_found => '手順が登録されていません';

  @override
  String get error_netowork => 'ネットワークに接続できません';
}
