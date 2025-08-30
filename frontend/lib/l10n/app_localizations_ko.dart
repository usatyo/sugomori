// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get menu_search => '차례검색';

  @override
  String get menu_register => '차례등록';

  @override
  String get menu_setting => '설정';

  @override
  String get title_setting => '설정';

  @override
  String get button_search => '검색';

  @override
  String get button_start => '시작하다';

  @override
  String get button_delete => '삭제';

  @override
  String get label_keyword => '검색 키워드';

  @override
  String get button_new => '신규';

  @override
  String get button_add => '추가';

  @override
  String get button_retry => '리트라이';

  @override
  String get goban_back => '1수 돌아가기';

  @override
  String get goban_back5 => '5수 돌아가기';

  @override
  String get goban_pass => '건너뛰기';

  @override
  String get goban_clear => '지우기';

  @override
  String get setting_language => '언어';

  @override
  String get message_video_not_found => '동영상을 찾을 수 없습니다';

  @override
  String get message_joseki_not_found => '절차가 아직 등록되지 않았습니다';

  @override
  String get error_netowork => '인터넷에 연결해주세요';

  @override
  String get error_max_stone => '배치할 수 있는 바둑돌의 최대 개수는 99개입니다';
}
