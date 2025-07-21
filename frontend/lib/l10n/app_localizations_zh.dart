// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get menu_search => '手续搜索';

  @override
  String get menu_register => '手续登记';

  @override
  String get menu_setting => '设置';

  @override
  String get title_setting => '设置';

  @override
  String get button_search => '搜索';

  @override
  String get button_start => '开始';

  @override
  String get button_delete => '除去';

  @override
  String get label_keyword => '搜索关键词';

  @override
  String get button_new => '新';

  @override
  String get button_add => '添加';

  @override
  String get goban_back => '1次回到';

  @override
  String get goban_back5 => '5次回到';

  @override
  String get goban_pass => '跳读';

  @override
  String get goban_clear => '清除';

  @override
  String get setting_language => '语言';

  @override
  String get message_video_not_found => '未找到视频';

  @override
  String get message_joseki_not_found => '手续尚未注册';

  @override
  String get error_netowork => '无法连接网络';

  @override
  String get error_max_stone => '最多可放置 99 块石头';
}
