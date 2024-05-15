import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:final_project_mobile/features/project/bloc/project_event.dart';
import 'package:final_project_mobile/features/project/repos/project_repository.dart';
import 'package:final_project_mobile/features/user/bloc/user_bloc.dart';
import 'package:final_project_mobile/models/project.dart';
import 'package:nb_utils/nb_utils.dart';
part 'project_state.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  final ProjectRepository projectRepository;

  ProjectBloc({required this.projectRepository}) : super(ProjectInitial()) {
    on<GetProject>(_getProject);
    on<CreateProject>(_createProject);
    on<GetProjectsByCompanyId>(_getProjectsByCompanyId);
    on<GetProjectById>(_getProjectById);
    on<DeleteProject>(_deleteProject);
    on<UpdateProject>(_updateProject);
    on<GetProjectsByProjectIds>(_getProjectsByProjectIds);
    on<GetProjectsByStudentId>(_getProjectsByStudentId);
    on<UpdateFavoriteProject>(_updateFavoriteProject);
    on<GetFavoriteProjectsByStudentId>(_getFavoriteProjectsByStudentId);
    on<StartWorkingOnProject>(_startWorkingOnProject);
    on<GetAllProjectsByStudentId>(_getAllProjectsOfStudents);
    on<SearchProjects>(_searchProjects);
  }

  Future<void> _getProject(GetProject event, Emitter<ProjectState> emit) async {
    try {
      final projects =
          await projectRepository.getProjects(pageNumber: event.page);
      emit(ProjectLoadSuccess(projects: projects, currentPage: event.page));
    } catch (error) {
      emit(ProjectOperationFailure(error: error.toString()));
    }
  }

  Future<void> _createProject(
      CreateProject event, Emitter<ProjectState> emit) async {
    try {
      await projectRepository.createProject(event.project);
      final projects = await projectRepository.getProjects();
      emit(ProjectLoadSuccess(projects: projects, currentPage: 1));
    } catch (error) {
      emit(ProjectOperationFailure(error: error.toString()));
    }
  }

  Future<void> _getProjectsByCompanyId(
      GetProjectsByCompanyId event, Emitter<ProjectState> emit) async {
    try {
      final projects = await projectRepository.getProjectsByCompanyId(
        event.companyId,
        null,
      );
      emit(MyProjectLoadSuccess(projects: projects));
    } catch (error) {
      emit(ProjectOperationFailure(error: error.toString()));
    }
  }

  Future<void> _getProjectById(
      GetProjectById event, Emitter<ProjectState> emit) async {
    try {
      emit(ProjectLoading(projectId: event.projectId.toInt()));
      final project = await projectRepository.getProjectById(event.projectId);
      emit(ProjectLoadingDone(project: project));
    } catch (error) {
      emit(ProjectOperationFailure(error: error.toString()));
    }
  }

  Future<void> _deleteProject(
      DeleteProject event, Emitter<ProjectState> emit) async {
    try {
      await projectRepository.deleteProject(event.projectId);
      emit(ProjectDeleteSuccess(
          projectId: event.projectId, message: 'Project deleted'));
    } catch (error) {
      emit(ProjectOperationFailure(error: error.toString()));
    }
  }

  Future<void> _updateProject(
      UpdateProject event, Emitter<ProjectState> emit) async {
    try {
      await projectRepository.updateProject(
        event.projectId,
        event.numberOfStudents,
        event.projectScopeFlag ?? 4,
        event.description,
        event.title ?? '',
        event.typeFlag,
        event.status,
      );
    } catch (error) {
      emit(ProjectOperationFailure(error: error.toString()));
    }
  }

  Future<void> _getProjectsByProjectIds(
      GetProjectsByProjectIds event, Emitter<ProjectState> emit) async {
    try {
      final projects =
          await projectRepository.getProjectsByProjectIds(event.projectIds);
      emit(ProjectsByIdsLoadingDone(projects: projects));
    } catch (error) {
      emit(ProjectOperationFailure(error: error.toString()));
    }
  }

  Future<void> _getProjectsByStudentId(
      GetProjectsByStudentId event, Emitter<ProjectState> emit) async {
    try {
      final projects = await projectRepository.getProjectsByStudentId(
          event.studentId, event.typeFlag);
      emit(GetProjectByStudentIdDone(
          projects: projects, typeFlag: event.typeFlag));
    } catch (error) {
      emit(ProjectOperationFailure(error: error.toString()));
    }
  }

  Future<void> _updateFavoriteProject(
      UpdateFavoriteProject event, Emitter<ProjectState> emit) async {
    try {
      await projectRepository.updateFavoriteProject(
          event.studentId, event.projectId, event.disableFlag);
      emit(FavoriteProjectUpdateSuccess(
          projectId: event.projectId,
          disableFlag: event.disableFlag == 1 ? true : false));
    } catch (error) {
      emit(ProjectOperationFailure(error: error.toString()));
    }
  }

  Future<void> _getFavoriteProjectsByStudentId(
      GetFavoriteProjectsByStudentId event, Emitter<ProjectState> emit) async {
    try {
      final projects = await projectRepository
          .getFavoriteProjectsByStudentID(event.studentId);
      emit(FavoriteProjectsLoadSuccess(projects: projects));
    } catch (error) {
      emit(ProjectOperationFailure(error: error.toString()));
    }
  }

  Future<void> _startWorkingOnProject(
      StartWorkingOnProject event, Emitter<ProjectState> emit) async {
    try {
      await projectRepository.startWorkingOnThisProject(
          event.projectId, event.updatedProject);
      final projects = await projectRepository.getProjectsByCompanyId(
          event.updatedProject.companyId ?? '', null);
      emit(MyProjectLoadSuccess(projects: projects));
    } catch (error) {
      emit(ProjectOperationFailure(error: error.toString()));
    }
  }

  Future<void> _getAllProjectsOfStudents(
      GetAllProjectsByStudentId event, Emitter<ProjectState> emit) async {
    try {
      emit(GetAllProjectsByStudentIdLoading(studentId: event.studentId));
      final projects =
          await projectRepository.getAllProjectsOfStudents(event.studentId);
      emit(GetAllProjectsByStudentIdSuccess(
          projects: projects, studentId: event.studentId));
    } catch (error) {
      emit(ProjectOperationFailure(error: error.toString()));
    }
  }

  Future<void> _searchProjects(
      SearchProjects event, Emitter<ProjectState> emit) async {
    try {
      final projects = await projectRepository.searchProjects(
        numberOfStudents: event.numberOfStudents,
        projectScopeFlag: event.projectScopeFlag,
        page: event.page ?? 1,
        perPage: event.perPage ?? 10,
        proposalsLessThan: event.proposalsLessThan,
        title: event.title,
      );
      emit(SearchProjectsSuccess(
          projects: projects, currentPage: event.page ?? 1));
    } catch (error) {
      emit(ProjectOperationFailure(error: error.toString()));
    }
  }
}
