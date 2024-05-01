part of 'project_bloc.dart';

abstract class ProjectState extends Equatable {
  const ProjectState();

  @override
  List<Object?> get props => [];
}

class ProjectInitial extends ProjectState {}

class ProjectLoadSuccess extends ProjectState {
  final List<Project> projects;

  const ProjectLoadSuccess({required this.projects});

  @override
  List<Object?> get props => [projects];
}

class ProjectOperationFailure extends ProjectState {
  final String error;

  const ProjectOperationFailure({required this.error});

  @override
  List<Object?> get props => [error];
}

class ProjectDeleteSuccess extends ProjectState {
  final String message;
  final String projectId;
  const ProjectDeleteSuccess({required this.projectId, required this.message});

  @override
  List<Object?> get props => [message];
}
