// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get menu_search => '查询操作步骤';

  @override
  String get menu_register => '注册';

  @override
  String get menu_setting => '设置';

  @override
  String get title_setting => '设置';

  @override
  String get button_search => '搜索';

  @override
  String get button_start => '开始';

  @override
  String get button_delete => '删除';

  @override
  String get label_keyword => '搜索关键词';

  @override
  String get button_new => '新建';

  @override
  String get button_add => '添加';

  @override
  String get button_retry => '重试';

  @override
  String get goban_back => '返回一步';

  @override
  String get goban_back5 => '返回五步';

  @override
  String get goban_pass => '脱先';

  @override
  String get goban_clear => '清除';

  @override
  String get setting_language => '语言';

  @override
  String get setting_license => '许可证';

  @override
  String get message_video_not_found => '未找到相关视频';

  @override
  String get message_joseki_not_found => '手续尚未注册';

  @override
  String get error_netowork => '请连接到互联网';

  @override
  String get error_max_stone => '最多可放置 99 块石头';
}
