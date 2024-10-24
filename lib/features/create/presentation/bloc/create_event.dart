part of 'create_bloc.dart';

@freezed
class CreateEvent with _$CreateEvent {
  const factory CreateEvent.idChanged(String id) = _CreateIdChanged;
  const factory CreateEvent.titleChanged(String? title) = _CreateTitleChanged;
  const factory CreateEvent.dueDateChanged(DateTime? dateTime) =
      _CreateDueDateChanged;
  const factory CreateEvent.startDateTimeChanged(DateTime? dateTime) =
      _CreateStartDateTimeChanged;
  const factory CreateEvent.endDateTimeChanged(DateTime? dateTime) =
      _CreateEndDateTimeChanged;
  const factory CreateEvent.typeEntryChanged(TodayEntryType? todayEntryType) =
      _CreateTypeEntryChanged;
  const factory CreateEvent.actionTypeChanged(ActionSelectionType? actionType) =
      _CreateActionTypeChanged;
  const factory CreateEvent.projectChanged(ProjectEntry? project) =
      _CreateProjectChanged;
  const factory CreateEvent.calendarChanged(CalendarEntry? calendar) =
      _CreateCalendarChanged;
  const factory CreateEvent.subTaskListChanged(List<SubTaskEntry> subTasks) =
      _CreateSubTaskListChanged;
  const factory CreateEvent.submit() = _CreateSubmission;
}
