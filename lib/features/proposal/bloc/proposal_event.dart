part of 'proposal_bloc.dart';

@immutable
abstract class ProposalEvent {}

class SubmitProposal extends ProposalEvent {
  final String projectId;
  final String studentId;
  final String coverLetter;

  SubmitProposal(
      {required this.projectId,
      required this.studentId,
      required this.coverLetter});
}

class UpdateProposal extends ProposalEvent {
  final String id;
  final String coverLetter;
  final String statusFlag;

  UpdateProposal(
      {required this.id, required this.coverLetter, required this.statusFlag});
}
