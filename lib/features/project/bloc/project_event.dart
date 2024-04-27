import 'package:equatable/equatable.dart';
import 'package:final_project_mobile/models/project.dart';

abstract class ProjectEvent extends Equatable {
  const ProjectEvent();

  @override
  List<Object?> get props => [];
}

class GetProject extends ProjectEvent {}

class CreateProject extends ProjectEvent {
  final Project project;

  const CreateProject({required this.project});

  @override
  List<Object?> get props => [project];
}

class GetProjectByCompanyId extends ProjectEvent {
  final String companyId;

  const GetProjectByCompanyId({required this.companyId});

  @override
  List<Object?> get props => [companyId];
}

class GetProjectById extends ProjectEvent {
  final String projectId;

  const GetProjectById({required this.projectId});

  @override
  List<Object?> get props => [projectId];
}

class DeleteProject extends ProjectEvent {
  final String projectId;

  const DeleteProject({required this.projectId});

  @override
  List<Object?> get props => [projectId];
}

class UpdateProject extends ProjectEvent {
  final String projectId;
  final Project updatedProject;

  const UpdateProject({required this.projectId, required this.updatedProject});

  @override
  List<Object?> get props => [projectId, updatedProject];
}
