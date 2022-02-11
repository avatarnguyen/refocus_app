import 'dart:io';

import 'package:logger/logger.dart';

// ignore: prefer_function_declarations_over_variables
final logger = (Type type) => Logger(
      printer: PrefixPrinter(
        PrettyPrinter(
          colors: !Platform.isIOS,
          methodCount: Platform.isIOS ? 2 : 0,
          lineLength: 90,
        ),
        location: '[${type.toString()}] ',
        // debug: "[${type.toString()}] ",
        // verbose: "[${type.toString()}] ",
        // info: "[${type.toString()}] ",
        // warning: '[${type.toString()}] ',
        // error: '[${type.toString()}] ',
      ),
      // level: Level.debug,
    );

class PrefixPrinter extends LogPrinter {
  PrefixPrinter(
    this._realPrinter, {
    this.location,
  }) : super();
  /* PrefixPrinter(
    this._realPrinter, {
    String? location,
    String? debug,
    String? verbose,
    String? wtf,
    String? info,
    String? warning,
    String? error,
    String? nothing,
  }) : super() {
    _prefixMap = {
      Level.debug: debug ?? "${'[32m'}  $location", // [0m
      Level.verbose: verbose ?? "${'[37m'} $location", // [0m
      Level.wtf: wtf ?? '[41m $location', // [0m
      Level.info: info ?? "${'[33m'} $location", // [0m
      Level.warning: warning ?? '[35m $location', // [0m
      Level.error: error ?? '[31m $location ', // [0m
      Level.nothing: nothing ?? '[90m $location', // [0m
    };
  } */

  final String? location;
  late final LogPrinter _realPrinter;
  // late Map<Level, String> _prefixMap;

  @override
  List<String> log(LogEvent event) {
    return _realPrinter.log(event).map((s) => s).toList();
  }
}
