import 'package:injectable/injectable.dart';
import 'package:refocus_app/features/task/domain/entities/subtask_entry.dart';
import 'package:rxdart/rxdart.dart';

@lazySingleton
class SubTaskStream {
  List<SubTaskEntry>? _subTasks;
  List<SubTaskEntry> get subTasks => _subTasks ?? <SubTaskEntry>[];
  set subTasks(List<SubTaskEntry>? value) => _subTasks = value;

  final BehaviorSubject<List<SubTaskEntry>> _subTaskSubject =
      BehaviorSubject<List<SubTaskEntry>>.seeded(<SubTaskEntry>[]);
  Stream<List<SubTaskEntry>> get subTaskStream => _subTaskSubject.stream;

  void broadCastCurrentTypeEntry(List<SubTaskEntry> entry) {
    _subTaskSubject.add(entry);
    _subTasks = entry;
  }
}
