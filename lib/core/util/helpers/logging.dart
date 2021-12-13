import 'dart:developer';

import 'package:logger/logger.dart';

// ignore: prefer_function_declarations_over_variables
final logger = (Type type) => Logger(
      printer: CustomPrinter(type.toString()),
      output: ConsoleOutput(),
      // level: Level.debug,
    );

class CustomPrinter extends LogPrinter {
  CustomPrinter(this.className);

  final String className;

  @override
  List<String> log(LogEvent event) {
    final color = PrettyPrinter.levelColors[event.level];
    final emoji = PrettyPrinter.levelEmojis[event.level];
    final dynamic message = event.message;

    return [color!('$emoji [$className] $message')];
  }
}

class ConsoleOutput extends LogOutput {
  @override
  void output(OutputEvent event) {
    for (var line in event.lines) {
      log(line);
    }
  }
}
