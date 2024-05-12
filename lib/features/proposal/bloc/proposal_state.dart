part of 'proposal_bloc.dart';

abstract class ProposalState extends Equatable {
  const ProposalState();

  @override
  List<Object?> get props => [];
}

class ProposalInitial extends ProposalState {}

class ProposalCreateSuccess extends ProposalState {
  final Proposal proposal;
  const ProposalCreateSuccess({required this.proposal});

  @override
  List<Object?> get props => [proposal];
}

class ProposalOperationFailure extends ProposalState {
  final String error;
  const ProposalOperationFailure({required this.error});

  @override
  List<Object?> get props => [error];
}

class ProposalCreateNE extends ProposalState {
  final String message;
  final Proposal? proposal;
  const ProposalCreateNE({required this.message, this.proposal});

  @override
  List<Object?> get props => [message];
}

class ProposalsByProjectIdLoaded extends ProposalState {
  final List<Proposal> proposals;
  const ProposalsByProjectIdLoaded({required this.proposals});

  @override
  List<Object?> get props => [proposals];
}

class SendHireOfferSuccess extends ProposalState {
  final Proposal proposal;
  const SendHireOfferSuccess({required this.proposal});

  @override
  List<Object?> get props => [proposal];
}
