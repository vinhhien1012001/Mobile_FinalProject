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

    // Make the HTTP request
    final response = await httpService.request(
      method: RequestMethod.get,
      url: url,
    );
    List<dynamic> _projects = (response['result'] as List);
    final projects = (response['result'] as List)
        .map((json) => Project.fromJson(json))
        .toList();
    return projects;
  }

  Future<Project> createProject(Project project) async {
    final newProject = await httpService.request(
      method: RequestMethod.post,
      url: '$baseUrl/project',
      body: project.toJson(),
    );
    return newProject;
  }

  Future<List<Project>> getProjectsByCompanyId(
      String companyId, int? typeFlag) async {
    String url = '$baseUrl/project/company/$companyId';
    if (typeFlag != null) {
      url += '?typeFlag=$typeFlag';
    }
    final response = await httpService.request(
      method: RequestMethod.get,
      url: url,
    );
    final projects = (response['result'] as List)
        .map((json) => Project.fromJson(json))
        .toList();
    return projects;
  }

  Future<Project> getProjectById(String projectId) async {
    final response = await httpService.request(
      method: RequestMethod.get,
      url: '$baseUrl/project/$projectId',
    );
    return Project.fromJson(response['result']);
  }

  Future<void> deleteProject(String projectId) async {
    await httpService.request(
      method: RequestMethod.delete,
      url: '$baseUrl/project/$projectId',
    );
  }

  // Can not use now
  Future<void> updateProject(String projectId, Project updatedProject) async {
    final result = await httpService.request(
        method: RequestMethod.patch,
        url: '$baseUrl/project/$projectId',
        body: {
          'projectScopeFlag': updatedProject.projectScopeFlag,
          'title': updatedProject.title,
          'description': updatedProject.description,
          'numberOfStudents': updatedProject.numberOfStudents,
          'typeFlag': updatedProject.typeFlag,
          'status': updatedProject.status,
        });
  }

  Future<void> startWorkingOnThisProject(
      String projectId, Project updatedProject) async {
    final Map<String, dynamic> requestBody = {
      'projectScopeFlag': updatedProject.projectScopeFlag,
      'title': updatedProject.title,
      'description': updatedProject.description,
      'numberOfStudents': updatedProject.numberOfStudents,
      'typeFlag': updatedProject.typeFlag,
    };

    // Conditionally include companyId if provided
    if (updatedProject.companyId != null) {
      requestBody['companyId'] = updatedProject.companyId!;
    }
    final result = await httpService.request(
        method: RequestMethod.patch,
        url: '$baseUrl/project/$projectId',
        body: requestBody);
  }

  Future<List<Project>> getProjectsByProjectIds(List<String> projectIds) async {
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
    return projects;
  }

  Future<List<Project>> getFavoriteProjectsByStudentID(int studentId) async {
    final response = await httpService.request(
      method: RequestMethod.get,
      url: '$baseUrl/favoriteProject/$studentId',
    );
    final projects = (response['result'] as List)
        .map((item) => Project.fromJson(item['project']))
        .toList();
    return projects;
  }

  Future<void> updateFavoriteProject(
      int studentId, int projectId, int disableFlag) async {
    final body = {
      'projectId': projectId,
      'disableFlag': disableFlag,
    };
    await httpService.request(
      method: RequestMethod.patch,
      url: '$baseUrl/favoriteProject/$studentId',
      body: body,
    );
  }
}
