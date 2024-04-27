import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:final_project_mobile/features/project/bloc/project_event.dart';
import 'package:final_project_mobile/features/project/repos/project_repository.dart';
import 'package:final_project_mobile/models/project.dart';

part 'project_state.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  final ProjectRepository projectRepository;

  ProjectBloc({required this.projectRepository}) : super(ProjectInitial()) {
    on<GetProject>(_getProject);
    on<CreateProject>(_createProject);
    on<GetProjectByCompanyId>(_getProjectByCompanyId);
    on<GetProjectById>(_getProjectById);
    on<DeleteProject>(_deleteProject);
    on<UpdateProject>(_updateProject);
  }

  Future<void> _getProject(GetProject event, Emitter<ProjectState> emit) async {
    try {
      final projects = await projectRepository.getProjects();
      emit(ProjectLoadSuccess(projects: projects));
    } catch (error) {
      emit(ProjectOperationFailure(error: error.toString()));
    }
  }

  Future<void> _createProject(
      CreateProject event, Emitter<ProjectState> emit) async {
    try {
      await projectRepository.createProject(event.project);
      final projects = await projectRepository.getProjects();
      emit(ProjectLoadSuccess(projects: projects));
    } catch (error) {
      emit(ProjectOperationFailure(error: error.toString()));
    }
  }

  Future<void> _getProjectByCompanyId(
      GetProjectByCompanyId event, Emitter<ProjectState> emit) async {
    try {
      final projects =
          await projectRepository.getProjectsByCompanyId(event.companyId);
      emit(ProjectLoadSuccess(projects: projects));
    } catch (error) {
      emit(ProjectOperationFailure(error: error.toString()));
    }
  }

  Future<void> _getProjectById(
      GetProjectById event, Emitter<ProjectState> emit) async {
    try {
      final project = await projectRepository.getProjectById(event.projectId);
      emit(ProjectLoadSuccess(projects: [project]));
    } catch (error) {
      emit(ProjectOperationFailure(error: error.toString()));
    }
  }

  Future<void> _deleteProject(
      DeleteProject event, Emitter<ProjectState> emit) async {
    try {
      await projectRepository.deleteProject(event.projectId);
      final projects = await projectRepository.getProjects();
      emit(ProjectLoadSuccess(projects: projects));
    } catch (error) {
      emit(ProjectOperationFailure(error: error.toString()));
    }
  }

  Future<void> _updateProject(
      UpdateProject event, Emitter<ProjectState> emit) async {
    try {
      await projectRepository.updateProject(
          event.projectId, event.updatedProject);
      final projects = await projectRepository.getProjects();
      emit(ProjectLoadSuccess(projects: projects));
    } catch (error) {
      emit(ProjectOperationFailure(error: error.toString()));
    }
  }
}
