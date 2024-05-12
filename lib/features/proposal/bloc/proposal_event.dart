part of 'proposal_bloc.dart';

@immutable
abstract class ProposalEvent extends Equatable {
  const ProposalEvent();
  @override
  List<Object> get props => [];
}

class SubmitProposal extends ProposalEvent {
  final String projectId;
  final String studentId;
  final String coverLetter;

  const SubmitProposal(
      {required this.projectId,
      required this.studentId,
      required this.coverLetter});
}

class UpdateProposal extends ProposalEvent {
  final String id;
  final String coverLetter;
  final String statusFlag;

  const UpdateProposal(
      {required this.id, required this.coverLetter, required this.statusFlag});

  @override
  List<Object> get props => [id, coverLetter, statusFlag];
}

class GetProposalsByProjectId extends ProposalEvent {
  final int projectId;

  const GetProposalsByProjectId({required this.projectId});

  @override
  List<Object> get props => [projectId];
}

class SendHireOffer extends ProposalEvent {
  final String proposalId;
  final int disableFlag;
  final int statusFlag;

  const SendHireOffer(
      {required this.proposalId,
      required this.disableFlag,
      required this.statusFlag});

  @override
  List<Object> get props => [proposalId, disableFlag, statusFlag];
}
