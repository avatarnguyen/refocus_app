import 'package:equatable/equatable.dart';
import 'package:refocus_app/features/task/domain/entities/project_entry.dart';

class ProjectParams extends Equatable {
  const ProjectParams(this.project);

  final ProjectEntry project;

  @override
  List<Object?> get props => [project];
}
