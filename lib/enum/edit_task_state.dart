/// [view] normal viewing mode
/// [editing] send signal to start editing task
/// [edited] send signal that editing task has been completed and
/// task should be reloaded
enum EditTaskState {
  view,
  editing,
  edited,
}
