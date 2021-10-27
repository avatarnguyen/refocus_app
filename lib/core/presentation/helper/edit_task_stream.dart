import 'package:injectable/injectable.dart';
import 'package:refocus_app/enum/edit_task_state.dart';
import 'package:rxdart/rxdart.dart';

@singleton
class EditTaskStream {
  final BehaviorSubject<EditTaskState> _editTaskSubject =
      BehaviorSubject<EditTaskState>.seeded(EditTaskState.view);

  Stream<EditTaskState> get editStateStream => _editTaskSubject.stream;

  void broadCastCurrentPage(EditTaskState state) {
    _editTaskSubject.add(state);
  }
}
