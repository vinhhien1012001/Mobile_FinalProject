part of 'project_bloc.dart';

abstract class ProjectState {
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

class MyProjectLoadSuccess extends ProjectState {
  final List<Project> projects;

  const MyProjectLoadSuccess({required this.projects});

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

class ProjectLoadingDone extends ProjectState {
  final Project project;
  const ProjectLoadingDone({required this.project});

  @override
  List<Object?> get props => [project];
}

class ProjectsByIdsLoadingDone extends ProjectState {
  final List<Project> projects;
  const ProjectsByIdsLoadingDone({required this.projects});

  @override
  List<Object?> get props => [projects];
}
