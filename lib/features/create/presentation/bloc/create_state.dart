part of 'create_bloc.dart';

@freezed
class CreateState with _$CreateState {
  const factory CreateState.current({
    required String id,
    String? title,
    DateTime? dueDate,
    DateTime? start,
    DateTime? end,
    TodayEntryType? todayEntryType,
    ActionSelectionType? actionType,
    ProjectEntry? project,
    CalendarEntry? calendar,
    List<SubTaskEntry>? subTasks,
    int? prio,
    bool? isHabit,
  }) = _CreateStateCurrent;
}
