import 'dart:developer';

import 'package:final_project_mobile/services/http_service.dart';
import 'package:final_project_mobile/models/project.dart';

class ProjectRepository {
  final String baseUrl = 'https://api.studenthub.dev/api';

  late HttpService httpService;

  ProjectRepository() {
    httpService = HttpService();
  }

  Future<List<Project>> getProjects(
      {int? pageNumber = 1, int? perPage = 10}) async {
    log('Getting projects');
    final response = await httpService.request(
      method: RequestMethod.get,
      url: pageNumber != null && perPage != null
          ? '$baseUrl/project?page=$pageNumber&perPage=$perPage'
          : '$baseUrl/project',
    );
    final projects = (response['result'] as List)
        .map((json) => Project.fromJson(json))
        .toList();
    return projects;
  }

  Future<Project> createProject(Project project) async {
    log('Creating project');
    final newProject = await httpService.request(
      method: RequestMethod.post,
      url: '$baseUrl/project',
      body: project.toJson(),
    );
    log('newProject: $newProject');
    return newProject;
  }

  Future<List<Project>> getProjectsByCompanyId(String companyId) async {
    log('Getting projects by company ID');
    final response = await httpService.request(
      method: RequestMethod.get,
      url: '$baseUrl/project/company/$companyId',
    );
    final projects = (response['result'] as List)
        .map((json) => Project.fromJson(json))
        .toList();
    return projects;
  }

  Future<Project> getProjectById(String projectId) async {
    log('Getting project by ID');
    final response = await httpService.request(
      method: RequestMethod.get,
      url: '$baseUrl/project/$projectId',
    );
    return Project.fromJson(response['result']);
  }

  Future<void> deleteProject(String projectId) async {
    log('Deleting project');
    await httpService.request(
      method: RequestMethod.delete,
      url: '$baseUrl/project/$projectId',
    );
  }

  Future<void> updateProject(String projectId, Project updatedProject) async {
    log('Updating project');
    await httpService.request(
      method: RequestMethod.patch,
      url: '$baseUrl/project/$projectId',
      body: updatedProject.toJson(),
    );
  }
}
