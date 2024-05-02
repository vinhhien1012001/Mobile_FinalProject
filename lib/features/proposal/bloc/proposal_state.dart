part of 'proposal_bloc.dart';

class ProposalState extends Equatable {
  final Proposal proposal;
  final List<Proposal> proposals;

  const ProposalState(
      {this.proposals = const <Proposal>[], this.proposal = const Proposal()});
  @override
  List<Object?> get props => [];

  ProposalState copyWith({List<Proposal>? proposals}) {
    return ProposalState(
      proposals: proposals ?? this.proposals,
    );
  }
}
