// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get menu_search => 'Search';

  @override
  String get menu_register => 'Register';

  @override
  String get menu_setting => 'Setting';

  @override
  String get title_setting => 'Setting';

  @override
  String get button_search => 'Search';

  @override
  String get button_start => 'Start';

  @override
  String get button_delete => 'Delete';

  @override
  String get label_keyword => 'keyword';

  @override
  String get button_new => 'New';

  @override
  String get button_add => 'Add';

  @override
  String get goban_back => 'Back';

  @override
  String get goban_back5 => '5 Back';

  @override
  String get goban_pass => 'Pass';

  @override
  String get goban_clear => 'Clear';

  @override
  String get setting_language => 'Language';

  @override
  String get message_video_not_found => 'No videos found';

  @override
  String get message_joseki_not_found => 'No procedures registered';

  @override
  String get error_netowork => 'Cannot connect to the network';

  @override
  String get error_max_stone => 'Cannot place over 100 stones';
}
