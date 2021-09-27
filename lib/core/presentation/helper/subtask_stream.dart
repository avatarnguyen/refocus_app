import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@lazySingleton
class SubTaskStream {
  List<String>? _subTasks;
  List<String> get subTasks => _subTasks ?? <String>[];
  set subTasks(List<String>? value) => _subTasks = value;

  final BehaviorSubject<List<String>> _subTaskSubject =
      BehaviorSubject<List<String>>.seeded(<String>[]);
  Stream<List<String>> get subTaskStream => _subTaskSubject.stream;

  void broadCastCurrentSubTaskListEntry(List<String> entry) {
    _subTaskSubject.add(entry);
    _subTasks = entry;
  }

  final BehaviorSubject<List<String>> _subTaskToSaveSubject =
      BehaviorSubject<List<String>>.seeded(<String>[]);
  Stream<List<String>> get subTaskToSaveStream => _subTaskToSaveSubject.stream;

  void broadCastToSaveSubTaskListEntry(List<String> entry) {
    _subTaskToSaveSubject.add(entry);
  }
}
