import 'dart:convert';
import 'dart:developer';

import 'package:final_project_mobile/models/student.dart';
import 'package:final_project_mobile/models/user_profile.dart';
import 'package:final_project_mobile/services/http_service.dart';

class DefaultRepository {
  final String baseUrl = 'https://api.studenthub.dev/api';

  late HttpService httpService;

  DefaultRepository() {
    httpService = HttpService();
  }

  Future<List<TechStack>> getTechStack() async {
    log('Getting techstacks');
    final response = await httpService.request(
      method: RequestMethod.get,
      url: '$baseUrl/techstack/getAllTechStack',
    );
    final stacks = (response['result'] as List)
        .map((json) => TechStack.fromJson(json))
        .toList();
    log('stacks IN REPO: $stacks');
    return stacks;
  }

  Future<List<SkillSet>> getSkillSet() async {
    log('Getting techstacks');
    final response = await httpService.request(
      method: RequestMethod.get,
      url: '$baseUrl/skillset/getAllSkillSet',
    );
    final skillset = (response['result'] as List)
        .map((json) => SkillSet.fromJson(json))
        .toList();
    log('skillset IN REPO: $skillset');
    return skillset;
  }

  Future<void> updateProfile(
      int studentId, int techStackId, List<int> skillSets) async {
    log('Update student profile in repository');
    await httpService.request(
      method: RequestMethod.put,
      url: '$baseUrl/profile/student/$studentId',
      body: (<String, dynamic>{
        'techStackId': techStackId,
        'skillSets': skillSets,
      }),
    );
  }

  Future<void> createStudentProfile(
      int techStackId, List<int> skillSets) async {
    log('Create student profile in repository');
    await httpService.request(
      method: RequestMethod.post,
      url: '$baseUrl/profile/student',
      body: (<String, dynamic>{
        'techStackId': techStackId,
        'skillSets': skillSets,
      }),
    );
  }

  Future<Company> createCompanyProfile(Company company) async {
    try {
      log('Create company profile');
      final newCompany = await httpService.request(
        method: RequestMethod.post,
        url: '$baseUrl/profile/company',
        body: company.toJson(),
      );
      if (newCompany['result'] == null) {
        String errorDetails =
            newCompany['errorDetails'].map((e) => e.toString()).join(' ');
        throw Exception(errorDetails);
      }

      log('newCompany: $newCompany');
      return newCompany;
    } catch (e) {
      log('ERRORS CATCH:');
      log(e.toString());
      rethrow;
    }
  }

  Future<void> updateLanguage(int studentId, List<Language> languages) async {
    try {
      log('Update language');
      log('language list parameter: ${languages.map((item) => item.toJson()).toList()}');
      final newLanguage = await httpService.request(
        method: RequestMethod.put,
        url: '$baseUrl/language/updateByStudentId/$studentId',
        body: (<String, dynamic>{
          'languages': languages.map((item) => item.toJson()).toList(),
        }),
      );
      if (newLanguage['result'] == null) {
        String errorDetails =
            newLanguage['errorDetails'].map((e) => e.toString()).join(' ');
        throw Exception(errorDetails);
      }
    } catch (e) {
      log('ERRORS CATCH:');
      log(e.toString());
      rethrow;
    }
  }
}
