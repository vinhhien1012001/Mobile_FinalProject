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

  Future<List<Project>> getProjectsByCompanyId(
      String companyId, int? typeFlag) async {
    log('Getting projects by company ID; $companyId');
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

  Future<void> updateProject(
    int projectId,
    int numberOfStudents,
    int? projectScopeFlag,
    String? description,
    String title,
    int? typeFlag,
    int? status,
  ) async {
    log('Updating project');

    // Create a map for the body
    final Map<String, dynamic> body = {
      'numberOfStudents': numberOfStudents,
    };

    // Add non-null fields to the body
    if (projectScopeFlag != null && projectScopeFlag != 4) {
      body['projectScopeFlag'] = projectScopeFlag;
    }
    if (title != null && title.isNotEmpty && title != '') {
      body['title'] = title;
    }
    if (description != null) {
      body['description'] = description;
    }
    if (typeFlag != null) {
      body['typeFlag'] = typeFlag;
    }
    if (status != null) {
      body['status'] = status;
    }

    // Make the HTTP request
    final result = await httpService.request(
      method: RequestMethod.patch,
      url: '$baseUrl/project/$projectId',
      body: body,
    );

    log('Updated project: $result');
  }

  Future<void> startWorkingOnThisProject(
      String projectId, Project updatedProject) async {
    log('start working on this project');
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
    log('start project: $result');
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
    return projects;
  }

  Future<List<Project>> getAllProjectsOfStudents(int studentId) async {
    log('Getting all projects of student ID: $studentId');
    final allResponses = [];

    for (var i = 0; i < 3; i++) {
      final response = await httpService.request(
        method: RequestMethod.get,
        url: '$baseUrl/project/student/$studentId?typeFlag=$i',
      );
      allResponses.add(response);
    }
    final projects = allResponses
        .map((response) => (response['result'] as List)
            .map((json) => Project.fromJson(json))
            .toList())
        .expand((element) => element)
        .toList();
    log('All projects of student ID: $projects');
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

  Future<List<Project>> searchProjects({
    String? title,
    int? projectScopeFlag,
    int? numberOfStudents,
    int? proposalsLessThan,
    int? page = 1, // Default value for page
    int? perPage = 10, // Default value for perPage
  }) async {
    // Construct the base URL
    String url = '$baseUrl/project';

    // Add query parameters if provided
    url +=
        '?page=$page&perPage=$perPage'; // Include page and perPage in the URL

    if (proposalsLessThan != null && proposalsLessThan != 0) {
      url += '&proposalsLessThan=$proposalsLessThan';
    }
    if (numberOfStudents != null && numberOfStudents != 0) {
      url += '&numberOfStudents=$numberOfStudents';
    }
    if (projectScopeFlag != null && projectScopeFlag != 4) {
      url += '&projectScopeFlag=$projectScopeFlag';
    }
    if (title != null && title.isNotEmpty) {
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
    log('projects searchs here: $projects');
    return projects;
  }
}
