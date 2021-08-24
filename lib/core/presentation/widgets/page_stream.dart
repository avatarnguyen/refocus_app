import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@singleton
class PageStream {
  final BehaviorSubject<int> _pageSubject = BehaviorSubject<int>.seeded(1);

  Stream<int> get pageStream => _pageSubject.stream;

  void broadCastCurrentPage(int currentPage) {
    _pageSubject.add(currentPage);
  }
}
