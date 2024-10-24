import 'package:equatable/equatable.dart';

class DateRangeParams extends Equatable {
  const DateRangeParams({
    required this.startDate,
    required this.endDate,
  });

  final DateTime startDate;
  final DateTime endDate;

  @override
  List<Object?> get props => [startDate, endDate];
}
