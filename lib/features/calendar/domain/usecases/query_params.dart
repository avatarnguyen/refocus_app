import 'package:equatable/equatable.dart';

class Params extends Equatable {
  const Params({
    required this.year,
    required this.month,
    this.day,
  });

  final String year;
  final String month;
  final String? day;

  @override
  List<Object?> get props => [year, month, day];
}
