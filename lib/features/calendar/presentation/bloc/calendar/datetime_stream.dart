import 'package:dartx/dartx.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@singleton
class DateTimeStream {
  final BehaviorSubject<DateTime> _dateTimeSubject =
      BehaviorSubject<DateTime>.seeded(DateTime.now());

  Stream<DateTime> get dateTimeStream => _dateTimeSubject.stream;

  void broadCastCurrentDate(DateTime date) {
    if (date.isToday) {
      _selectedDate = null;
    } else {
      _selectedDate = date;
    }
    _dateTimeSubject.add(date);
  }

  DateTime? _selectedDate;
  DateTime? get selectedDate => _selectedDate;
  set selectedDate(DateTime? entry) {
    _selectedDate = entry;
  }
}
