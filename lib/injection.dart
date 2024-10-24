import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injection.config.dart';

// command: flutter pub run build_runner watch --delete-conflicting-outputs

final getIt = GetIt.instance;

@injectableInit
Future<void> configureDependencies(String environment) async =>
    await $initGetIt(getIt, environment: environment);

abstract class Env {
  static const dev = 'dev';
  static const prod = 'prod';
}
