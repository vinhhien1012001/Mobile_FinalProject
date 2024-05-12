import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:final_project_mobile/features/default/bloc/default_event.dart';
import 'package:final_project_mobile/features/default/repos/default_repository.dart';
import 'package:final_project_mobile/models/student.dart';
part 'default_state.dart';

class DefaultBloc extends Bloc<DefaultEvent, DefaultState> {
  final DefaultRepository defaultRepository = DefaultRepository();

  DefaultBloc({required DefaultRepository repository})
      : super(DefaultInitial()) {
    on<GetAllTechStack>(_fetchAllTechStack);
    on<GetAllSkillSet>(_fetchAllSkillSet);
    on<UpdateProfile>(_updateProfile);
  }

  Future<void> _fetchAllTechStack(
      GetAllTechStack event, Emitter<DefaultState> emit) async {
    try {
      final stacks = await defaultRepository.getTechStack();
      emit(DefaultLoadSuccess(stacks: stacks));
    } catch (error) {
      emit(DefaultOperationFailure(error: error.toString()));
    }
  }

  Future<void> _fetchAllSkillSet(
      GetAllSkillSet event, Emitter<DefaultState> emit) async {
    try {
      final skillsets = await defaultRepository.getSkillSet();
      emit(SkillSetLoadSuccess(skillsets: skillsets));
    } catch (error) {
      emit(DefaultOperationFailure(error: error.toString()));
    }
  }

  Future<void> _updateProfile(
      UpdateProfile event, Emitter<DefaultState> emit) async {
    try {
      await defaultRepository.updateProfile(
          event.studentId, event.techStackId, event.skillSets);
      emit(UpdateProfileSuccess());
    } catch (error) {
      emit(DefaultOperationFailure(error: error.toString()));
    }
  }
}
