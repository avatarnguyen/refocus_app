import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

// ignore: prefer_function_declarations_over_variables
// printer: CustomPrinter(type.toString()),
// (Type type) =>
final logger = (Type type) => Logger(
      printer: PrefixPrinter(
        PrettyPrinter(
          colors: false,
          printTime: true,
        ),
      ),
      output: ConsoleOutput(),
      // level: Level.debug,
    );

class CustomPrinter extends LogPrinter {
  final String className;

  CustomPrinter(this.className);

  @override
  List<String> log(LogEvent event) {
    final color = PrettyPrinter.levelColors[event.level];
    final emoji = PrettyPrinter.levelEmojis[event.level];
    final dynamic message = event.message;

    return [color!('$emoji [$className] $message')];
  }
}

class PrefixPrinter extends LogPrinter {
  late final LogPrinter _realPrinter;
  late Map<Level, String> _prefixMap;

  PrefixPrinter(
    this._realPrinter, {
    String? debug,
    String? verbose,
    String? wtf,
    String? info,
    String? warning,
    String? error,
    String? nothing,
  }) : super() {
    _prefixMap = {
      Level.debug: debug ?? r'\033[38;5;10m ',
      Level.verbose: verbose ?? r'\033[38;5;8m ',
      Level.wtf: wtf ?? r'\033[38;5;165m ',
      Level.info: info ?? r'\033[38;5;6m ',
      Level.warning: warning ?? r'\033[38;5;11m ',
      Level.error: error ?? r'\033[38;5;9m ',
      Level.nothing: nothing ?? r'\033[38;5;0m',
    };
  }

  @override
  List<String> log(LogEvent event) {
    return _realPrinter
        .log(event)
        .map((s) => '${_prefixMap[event.level]}$s')
        .toList();
  }
}

class ConsoleOutput extends LogOutput {
  @override
  void output(OutputEvent event) {
    for (final line in event.lines) {
      debugPrint(line);
    }
  }
}
