import 'dart:developer';

import 'package:final_project_mobile/services/http_service.dart';
import 'package:final_project_mobile/models/project.dart';

class ProjectRepository {
  final String baseUrl = 'https://api.studenthub.dev/api';

  late HttpService httpService;

  ProjectRepository() {
    httpService = HttpService();
  }

  Future<List<Project>> getProjects({
    int? pageNumber,
    int perPage = 10, // Set a default value of 10 for perPage
    int? proposalsLessThan,
    int? numberOfStudents,
    int? projectScopeFlag,
    String? title,
  }) async {
    log('Getting projects');
    log('Getting PageNumber: $pageNumber');
    // Construct the base URL
    String url = '$baseUrl/project';

    // Add query parameters if provided
    url +=
        '?page=$pageNumber&perPage=$perPage'; // Include pageNumber and perPage in the URL

    if (proposalsLessThan != null) {
      url += '&proposalsLessThan=$proposalsLessThan';
    }
    if (numberOfStudents != null) {
      url += '&numberOfStudents=$numberOfStudents';
    }
    if (projectScopeFlag != null) {
      url += '&projectScopeFlag=$projectScopeFlag';
    }
    if (title != null) {
      url += '&title=$title';
    }

    log('url: $url');
    // Make the HTTP request
    final response = await httpService.request(
      method: RequestMethod.get,
      url: url,
    );
    List<dynamic> _projects = (response['result'] as List);
    final projects = (response['result'] as List)
        .map((json) => Project.fromJson(json))
        .toList();
    log('projects 2 here: $projects');
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
    log('Getting projects by company ID; $companyId');
    final response = await httpService.request(
      method: RequestMethod.get,
      url: '$baseUrl/project/company/$companyId',
    );
    final projects = (response['result'] as List)
        .map((json) => Project.fromJson(json))
        .toList();
    log('projects ne`: $projects');
    return projects;
  }

  Future<Project> getProjectById(String projectId) async {
    log('Getting project by ID $projectId');
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

  Future<List<Project>> getProjectsByProjectIds(List<String> projectIds) async {
    log('Getting projects by project IDs');
    List<Project> projects = [];
    for (var projectId in projectIds) {
      final response = await httpService.request(
        method: RequestMethod.get,
        url: '$baseUrl/project/$projectId',
      );
      projects.add(Project.fromJson(response['result']));
    }
    return projects;
  }

  Future<List<Project>> getProjectsByStudentId(
      int studentId, List<int> typeFlag) async {
    log('Getting projects by student ID');
    List<Project> projects = [];
    for (var type in typeFlag) {
      final response = await httpService.request(
        method: RequestMethod.get,
        url: '$baseUrl/project/student/$studentId?typeFlag=$type',
      );
      projects = (response['result'] as List)
          .map((json) => Project.fromJson(json))
          .toList();
    }
    log('projects by studentId ne`: $projects');
    log('TypeFlag ne`: $typeFlag');
    return projects;
  }

  Future<List<Project>> getFavoriteProjectsByStudentID(int studentId) async {
    log('Getting favorite projects for student ID: $studentId');
    final response = await httpService.request(
      method: RequestMethod.get,
      url: '$baseUrl/favoriteProject/$studentId',
    );
    final projects = (response['result'] as List)
        .map((item) => Project.fromJson(item['project']))
        .toList();
    log('Favorite projects: $projects');
    return projects;
  }

  Future<void> updateFavoriteProject(
      int studentId, int projectId, int disableFlag) async {
    log('Updating favorite project for student ID: $studentId');
    final body = {
      'projectId': projectId,
      'disableFlag': disableFlag,
    };
    await httpService.request(
      method: RequestMethod.patch,
      url: '$baseUrl/favoriteProject/$studentId',
      body: body,
    );
    log('Favorite project updated successfully');
  }
}
