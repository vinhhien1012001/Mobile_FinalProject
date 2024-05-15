import 'package:equatable/equatable.dart';
import 'package:final_project_mobile/models/project.dart';

abstract class ProjectEvent extends Equatable {
  const ProjectEvent();

  @override
  List<Object?> get props => [];
}

class GetProject extends ProjectEvent {
  final int page; // New parameter for page number

  const GetProject({required this.page}); // Default value of 1 for page number

  @override
  List<Object> get props => [page];
}

class CreateProject extends ProjectEvent {
  final Project project;

  const CreateProject({required this.project});

  @override
  List<Object?> get props => [project];
}

class GetProjectsByCompanyId extends ProjectEvent {
  final String companyId;
  final int? typeFlag;
  const GetProjectsByCompanyId({required this.companyId, this.typeFlag});

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

class GetProjectsByProjectIds extends ProjectEvent {
  final List<String> projectIds;

  const GetProjectsByProjectIds({required this.projectIds});

  @override
  List<Object?> get props => [projectIds];
}

class GetProjectsByStudentId extends ProjectEvent {
  final int studentId;
  final List<int> typeFlag;

  const GetProjectsByStudentId(
      {required this.studentId, required this.typeFlag});

  @override
  List<Object?> get props => [studentId, typeFlag];
}

class GetFavoriteProjectsByStudentId extends ProjectEvent {
  final int studentId;

  const GetFavoriteProjectsByStudentId({required this.studentId});

  @override
  List<Object?> get props => [studentId];
}

class UpdateFavoriteProject extends ProjectEvent {
  final int studentId;
  final int projectId;
  final int disableFlag;
  const UpdateFavoriteProject(
      {required this.studentId,
      required this.projectId,
      required this.disableFlag});

  @override
  List<Object?> get props => [studentId, projectId, disableFlag];
}

class StartWorkingOnProject extends ProjectEvent {
  final String projectId;
  final Project updatedProject;

  const StartWorkingOnProject(
      {required this.projectId, required this.updatedProject});

  @override
  List<Object?> get props => [projectId, updatedProject];
}

class GetAllProjectsByStudentId extends ProjectEvent {
  final int studentId;

  const GetAllProjectsByStudentId({required this.studentId});

  @override
  List<Object?> get props => [studentId];
}

class SearchProjects extends ProjectEvent {
  final String? title;
  final int? projectScopeFlag;
  final int? numberOfStudents;
  final int? proposalsLessThan;
  final int? page;
  final int? perPage;

  const SearchProjects({
    this.title,
    this.projectScopeFlag,
    this.numberOfStudents,
    this.proposalsLessThan,
    this.page,
    this.perPage,
  });

  @override
  List<Object?> get props => [
        title,
        projectScopeFlag,
        numberOfStudents,
        proposalsLessThan,
        page,
        perPage
      ];
}
