import 'dart:developer';

import 'package:injectable/injectable.dart';
import 'package:refocus_app/core/error/exceptions.dart';
import 'package:refocus_app/features/setting/data/models/setting_entry_model.dart';
import 'package:refocus_app/features/setting/domain/entities/setting_entry.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SettingLocalDataSource {
  Future<SettingEntryModel> getLocalSettingData(String id);
  Future<void> saveLocalSettingData(SettingEntryModel entry);
  Future<void> deleteLocalSettingData(SettingEntryModel entry);
}

@LazySingleton(as: SettingLocalDataSource)
class SharedPrefSettingLocalDataSource implements SettingLocalDataSource {
  SharedPrefSettingLocalDataSource(this.sharedPreferences);

  final SharedPreferences sharedPreferences;

  @override
  Future<void> deleteLocalSettingData(SettingEntryModel entry) {
    try {
      return sharedPreferences.remove(entry.settingEntry.id);
    } catch (e) {
      log('$e');
      throw CacheException();
    }
  }

  @override
  Future<SettingEntryModel> getLocalSettingData(String id) {
    try {
      if (sharedPreferences.containsKey(id)) {
        final _data = sharedPreferences.getString(id);
        return Future.value(
            SettingEntryModel(settingEntry: SettingEntry(id: id, data: _data)));
      } else {
        log('There is no data with the given key (id)');
        throw CacheException();
      }
    } catch (e) {
      log('$e');
      throw CacheException();
    }
  }

  @override
  Future<void> saveLocalSettingData(SettingEntryModel entry) {
    try {
      return sharedPreferences.setString(
          entry.settingEntry.id, entry.settingEntry.data ?? '');
    } catch (e) {
      log('$e');
      throw CacheException();
    }
  }
}
