import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:final_project_mobile/features/proposal/repos/proposal_repository.dart';
import 'package:final_project_mobile/models/proposal.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'proposal_event.dart';
part 'proposal_state.dart';

class ProposalBloc extends Bloc<ProposalEvent, ProposalState> {
  final ProposalRepository proposalRepository;
  ProposalBloc({required this.proposalRepository})
      : super(const ProposalState()) {
    on<SubmitProposal>(_submitProposal);
    on<UpdateProposal>(_updateProposal);
  }

  FutureOr<void> _updateProposal(
      UpdateProposal event, Emitter<ProposalState> emit) async {}

  FutureOr<void> _submitProposal(
      SubmitProposal event, Emitter<ProposalState> emit) async {}
}
