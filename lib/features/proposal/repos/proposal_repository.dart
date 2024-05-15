import 'dart:developer';

import 'package:final_project_mobile/models/proposal.dart';
import 'package:final_project_mobile/services/http_service.dart';

class ProposalRepository {
  final String baseUrl = 'https://api.studenthub.dev/api';

  late HttpService httpService;

  ProposalRepository() {
    httpService = HttpService();
  }

  Future<List<Proposal>> getProposalsByProjectId(int projectId) async {
    final response = await httpService.request(
      method: RequestMethod.get,
      url: '$baseUrl/proposal/getByProjectId/$projectId',
    );
    final List<dynamic> jsonProposals = response['result']['items'];
    return jsonProposals.map((json) => Proposal.fromJson(json)).toList();
  }

  Future<List<Proposal>> getProposalsByStudentId(int studentId) async {
    final response = await httpService.request(
      method: RequestMethod.get,
      url: '$baseUrl/proposal/student/$studentId',
    );
    final List<dynamic> jsonProposals = response['result'];
    return jsonProposals.map((json) => Proposal.fromJson(json)).toList();
  }

  Future<Proposal> getProposalById(int proposalId) async {
    final response = await httpService.request(
      method: RequestMethod.get,
      url: '$baseUrl/proposal/$proposalId',
    );
    return Proposal.fromJson(response['result']);
  }

  Future<Map<String, dynamic>> submitProposal(
      String projectId, String coverLetter, String studentId) async {
    final newwProposal = await httpService.request(
      method: RequestMethod.post,
      url: '$baseUrl/proposal',
      body: {
        'projectId': projectId,
        'coverLetter': coverLetter,
        'studentId': studentId,
      },
    );
    return newwProposal;
  }

  Future<void> updateProposal(Proposal proposal) async {
    await httpService.request(
      method: RequestMethod.put,
      url: '$baseUrl/proposal/${proposal.id}',
      body: proposal.toJson(),
    );
  }

  Future<Proposal> sendHireOffer(
      String proposalId, int disableFlag, int statusFlag) async {
    final response = await httpService.request(
      method: RequestMethod.patch,
      url: '$baseUrl/proposal/$proposalId',
      body: {
        'disableFlag': disableFlag,
        'statusFlag': statusFlag,
      },
    );
    // Todo: return the proposal object
    return Proposal(
        id: response['result']['id'],
        projectId: response['result']['projectId'],
        createdAt: response['result']['createdAt'],
        updatedAt: response['result']['updatedAt'],
        deletedAt: response['result']['deletedAt'],
        studentId: response['result']['studentId'],
        coverLetter: response['result']['coverLetter'],
        statusFlag: response['result']['statusFlag'],
        disableFlag: response['result']['disableFlag'],
        student: Student(
          id: response['result']['student']['id'],
          createdAt: response['result']['student']['createdAt'],
          updatedAt: response['result']['student']['updatedAt'],
          deletedAt: response['result']['student']['deletedAt'],
          userId: response['result']['student']['userId'],
          techStackId: response['result']['student']['techStackId'],
          resume: response['result']['student']['resume'],
          transcript: response['result']['student']['transcript'],
          educations: response['result']['student']['educations'],
          // TechStack.fromJson(response['result']['student']['techStack']),
        ));
  }

  Future<List<Proposal>> getAllProposalsOfStudent(int studentId) async {
    final response = await httpService.request(
      method: RequestMethod.get,
      url: '$baseUrl/proposal/student/$studentId',
    );
    final List<dynamic> jsonProposals = response['result'];
    log('PROPOSALS: $jsonProposals');
    final f = jsonProposals.map((json) => Proposal.fromJson(json)).toList();
    log('PROPOSALS: $f');
    return f;
  }
}
