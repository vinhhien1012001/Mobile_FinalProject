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
    on<GetProposalsByProjectId>(_getProposalsByProjectId);
    on<SendHireOffer>(_sendHireOffer);
    on<GetAllProposalsOfStudent>(_getAllProposalsOfStudent);
  }

  Future<void> _updateProposal(
      UpdateProposal event, Emitter<ProposalState> emit) async {}

  Future<void> _submitProposal(
      SubmitProposal event, Emitter<ProposalState> emit) async {
    try {
      final response = await proposalRepository.submitProposal(
          event.projectId, event.coverLetter, event.studentId);
      final result = response['result']; // Access 'result' field
      final Proposal proposal = Proposal(
        // Customize the creation of Proposal object field by field
        id: result['id'],
        createdAt: result['createdAt'],
        updatedAt: result['updatedAt'],
        deletedAt: result['deletedAt'],
        projectId: int.parse(result['projectId']),
        studentId: int.parse(result['studentId']),
        coverLetter: result['coverLetter'],
        statusFlag: result['statusFlag'],
        disableFlag: result['disableFlag'],
      );
      emit(ProposalCreateNE(
          message: 'Success ${event.projectId + event.studentId}',
          proposal: proposal));
    } catch (error) {
      emit(ProposalOperationFailure(error: error.toString()));
    }
  }

  Future<void> _getProposalsByProjectId(
      GetProposalsByProjectId event, Emitter<ProposalState> emit) async {
    try {
      final List<Proposal> proposals =
          await proposalRepository.getProposalsByProjectId(event.projectId);
      if (proposals.isEmpty) {
        emit(ProposalOperationFailure(error: 'No proposals found'));
      } else {
        emit(ProposalsByProjectIdLoaded(
            proposals: proposals, projectId: event.projectId));
      }
    } catch (error) {
      emit(ProposalOperationFailure(error: error.toString()));
    }
  }

  Future<void> _sendHireOffer(
      SendHireOffer event, Emitter<ProposalState> emit) async {
    try {
      final response = await proposalRepository.sendHireOffer(
          event.proposalId, event.disableFlag, event.statusFlag);
      log('SEND OFFER NE`: $response');
      emit(SendHireOfferSuccess(proposal: response));
    } catch (error) {
      emit(ProposalOperationFailure(error: error.toString()));
    }
  }

  Future<void> _getAllProposalsOfStudent(
      GetAllProposalsOfStudent event, Emitter<ProposalState> emit) async {
    try {
      final List<Proposal> proposals =
          await proposalRepository.getAllProposalsOfStudent(event.studentId);

      emit(GetAllProposalsOfStudentSuccess(
          proposals: proposals, studentId: event.studentId));
    } catch (error) {
      emit(ProposalOperationFailure(error: error.toString()));
    }
  }
}
