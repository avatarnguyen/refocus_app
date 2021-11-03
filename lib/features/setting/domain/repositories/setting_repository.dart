import 'package:dartz/dartz.dart';
import 'package:refocus_app/core/error/failures.dart';
import 'package:refocus_app/features/setting/domain/entities/setting_entry.dart';

abstract class SettingRepository {
  Future<Either<Failure, SettingEntry>> getSettingData(String id);
  Future<Either<Failure, Unit>> saveSettingData(SettingEntry settingEntry);
  Future<Either<Failure, Unit>> deleteSettingData(String id);
}
