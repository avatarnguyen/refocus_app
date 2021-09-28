import 'package:injectable/injectable.dart';
import 'package:refocus_app/enum/action_selection_type.dart';
import 'package:rxdart/rxdart.dart';

@lazySingleton
class ActionStream {
  final BehaviorSubject<ActionSelectionType> _actionSubject =
      BehaviorSubject<ActionSelectionType>.seeded(ActionSelectionType.task);

  Stream<ActionSelectionType> get actionTypeStream => _actionSubject.stream;

  void broadCastCurrentActionType(ActionSelectionType type) {
    _actionSubject.add(type);
  }
}
