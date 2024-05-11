import 'dart:convert';
import 'dart:developer';

import 'package:final_project_mobile/models/student.dart';
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
    return skillset;
  }

  Future<void> updateProfile(
      String studentId, String techStackId, List<SkillSet> skillSets) async {
    log('Update profile');
    // final body<String, dynamic> = {
    //   'techStackId': techStackId,
    //   'skillSets': skillSets.map((skillSet) => skillSet.toJson()).toList(),
    // };
    await httpService.request(
      method: RequestMethod.patch,
      url: '$baseUrl/profile/student/$studentId',
      body: (<String, dynamic>{
        'techStackId': techStackId,
        'skillSets': skillSets.map((skillSet) => skillSet.toJson()).toList(),
      }),
    );
  }
}
