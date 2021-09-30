import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@singleton
class EditTaskStream {
  final BehaviorSubject<bool> _editTaskSubject =
      BehaviorSubject<bool>.seeded(false);

  Stream<bool> get editStateStream => _editTaskSubject.stream;

  void broadCastCurrentPage(bool isEdit) {
    _editTaskSubject.add(isEdit);
  }
}
