import 'dart:async';

import 'package:injectable/injectable.dart';

@lazySingleton
class TextStream {
  final _textController = StreamController<String>.broadcast();

  Stream<String> get getTextStream =>
      _textController.stream.asBroadcastStream();

  void updateText(String? text) {
    (text == null || text.isEmpty)
        ? _textController.sink.addError('Invalid value entered!')
        : _textController.sink.add(text);
  }

  void dispose() {
    _textController.close();
  }
}
