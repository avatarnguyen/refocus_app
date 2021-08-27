import 'package:injectable/injectable.dart';
import 'package:refocus_app/enum/today_entry_type.dart';

@lazySingleton
class SettingOption {
  TodayEntryType? _type;
  TodayEntryType get type => _type ?? TodayEntryType.task;
  set type(TodayEntryType? value) => _type = value;
}
