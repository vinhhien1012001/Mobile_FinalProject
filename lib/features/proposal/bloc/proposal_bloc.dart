import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:final_project_mobile/features/proposal/repos/proposal_repository.dart';
import 'package:final_project_mobile/models/proposal.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'proposal_event.dart';
part 'proposal_state.dart';

class ProposalBloc extends Bloc<ProposalEvent, ProposalState> {
  final ProposalRepository proposalRepository = ProposalRepository();

  ProposalBloc({required ProposalRepository repository})
      : super(ProposalInitial()) {
    on<SubmitProposal>(_submitProposal);
    on<UpdateProposal>(_updateProposal);
  }

  Future<void> _updateProposal(
      UpdateProposal event, Emitter<ProposalState> emit) async {}

  // Future<void> _submitProposal(
  //     SubmitProposal event, Emitter<ProposalState> emit) async {
  //   try {
  //     log('Inside submitProposal');
  //     final response = await proposalRepository.submitProposal(
  //         event.projectId, event.coverLetter, event.studentId);
  //     log('response in proposal: $response');
  //     emit(const ProposalCreateSuccess(message: "Success"));
  //   } catch (e) {
  //     final errorMessage = 'Failed to submit proposal at ${DateTime.now()}';
  //     emit(ProposalOperationFailure(error: errorMessage));
  //   }
  // }

  Future<void> _submitProposal(
      SubmitProposal event, Emitter<ProposalState> emit) async {
    try {
      final a = await proposalRepository.submitProposal(
          event.projectId, event.coverLetter, event.studentId);
      log('response in proposal: $a');
      emit(
          ProposalCreateNE(message: 'Success', proposal: Proposal.fromJson(a)));
    } catch (error) {
      emit(ProposalInitial());
      emit(ProposalOperationFailure(error: error.toString()));
    }
  }
}
