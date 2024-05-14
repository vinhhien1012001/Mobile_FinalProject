import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:final_project_mobile/features/default/bloc/default_event.dart';
import 'package:final_project_mobile/features/default/repos/default_repository.dart';
import 'package:final_project_mobile/models/student.dart';
import 'package:final_project_mobile/models/user_profile.dart';
part 'default_state.dart';

class DefaultBloc extends Bloc<DefaultEvent, DefaultState> {
  final DefaultRepository defaultRepository = DefaultRepository();

  DefaultBloc({required DefaultRepository repository})
      : super(DefaultInitial()) {
    on<GetAllTechStack>(_fetchAllTechStack);
    on<GetAllSkillSet>(_fetchAllSkillSet);
    on<UpdateProfile>(_updateProfile);
    on<CreateCompanyProfile>(_createCompanyProfile);
    on<CreateStudentProfile>(_createStudentProfile);
    on<UpdateLanguage>(_updateLanguage);
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

  Future<void> _createStudentProfile(
      CreateStudentProfile event, Emitter<DefaultState> emit) async {
    try {
      await defaultRepository.createStudentProfile(
          event.techStackId, event.skillSets);
      emit(UpdateProfileSuccess());
    } catch (error) {
      emit(DefaultOperationFailure(error: error.toString()));
    }
  }

  Future<void> _createCompanyProfile(
      CreateCompanyProfile event, Emitter<DefaultState> emit) async {
    try {
      await defaultRepository.createCompanyProfile(event.company);
      emit(UpdateProfileSuccess());
    } catch (error) {
      emit(DefaultInitial());
      emit(CreateProfileFailure(error: error.toString()));
    }
  }

  Future<void> _updateLanguage(
      UpdateLanguage event, Emitter<DefaultState> emit) async {
    try {
      await defaultRepository.updateLanguage(event.studentId, event.languages);
      emit(UpdateLanguageSuccess());
    } catch (error) {
      emit(DefaultInitial());
      emit(DefaultOperationFailure(error: error.toString()));
    }
  }
}
