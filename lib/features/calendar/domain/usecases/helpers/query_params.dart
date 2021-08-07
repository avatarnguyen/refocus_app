import 'package:equatable/equatable.dart';

class Params extends Equatable {
  const Params({
    required this.year,
    required this.month,
    this.day,
  });

  final int year;
  final int month;
  final int? day;

  @override
  List<Object?> get props => [year, month, day];
}
