import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@lazySingleton
class NotesStream {
  String? _notes;
  String get notes => _notes ?? '';
  set notes(String? value) => _notes = value;

  final BehaviorSubject<String> _notesSubject =
      BehaviorSubject<String>.seeded('');
  Stream<String> get notesStream => _notesSubject.stream;

  void broadCastCurrentTypeEntry(String entry) {
    _notesSubject.add(entry);
    _notes = entry;
  }
}
