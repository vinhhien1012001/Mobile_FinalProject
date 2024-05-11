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
    log('response in proposal: $jsonProposals');
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
}
