import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@singleton
class DateTimeStream {
  final BehaviorSubject<DateTime> _dateTimeSubject =
      BehaviorSubject<DateTime>.seeded(DateTime.now());

  Stream<DateTime> get dateTimeStream => _dateTimeSubject.stream;

  void broadCastCurrentDate(DateTime date) {
    _dateTimeSubject.add(date);
  }
}
