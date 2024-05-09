// import 'dart:async';
// import 'dart:developer';

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
// import 'package:final_project_mobile/features/proposal/repos/proposal_repository.dart';
// import 'package:final_project_mobile/models/proposal.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'default_event.dart';
part 'default_state.dart';

class DefaultBloc extends Bloc<DefaultEvent, DefaultState> {
  DefaultBloc() : super(DefaultInitial()) {
    on<FetchAllTechStackEvent>(_fetchAllTechStack);
  }

  FutureOr<void> _fetchAllTechStack(
      FetchAllTechStackEvent event, Emitter<DefaultState> emit) async {
    // try {
    //   final stacks = await projectRepository.getProjects();
    //   emit(ProjectLoadSuccess(projects: projects));
    // } catch (error) {
    //   emit(ProjectOperationFailure(error: error.toString()));
    // }
  }
}
