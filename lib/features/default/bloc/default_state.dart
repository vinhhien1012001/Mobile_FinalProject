part of 'default_bloc.dart';

abstract class DefaultState extends Equatable {
  const DefaultState();

  @override
  List<Object?> get props => [];
}

class DefaultInitial extends DefaultState {}

class DefaultLoadSuccess extends DefaultState {
  final List<TechStack> stacks;

  const DefaultLoadSuccess({required this.stacks});

  @override
  List<Object?> get props => [stacks];
}

class SkillSetLoadSuccess extends DefaultState {
  final List<SkillSet> skillsets;

  const SkillSetLoadSuccess({required this.skillsets});

  @override
  List<Object?> get props => [skillsets];
}

class DefaultOperationFailure extends DefaultState {
  final String error;

  const DefaultOperationFailure({required this.error});

  @override
  List<Object?> get props => [error];
}

class UpdateProfileSuccess extends DefaultState {
  // final List<SkillSet> skillsets;
  // final String techStackId;

  // const UpdateProfileSuccess(
  //     {required this.skillsets, required this.techStackId});

  // @override
  // List<Object?> get props => [skillsets, techStackId];
}

// class DefaultLoadingDone extends DefaultState {
//   final String projectId;
//   const DefaultLoadingDone({required this.projectId});

//   @override
//   List<Object?> get props => [projectId];
// }

class CreateCompanyProfileSuccess extends DefaultState {
  final Company company;

  const CreateCompanyProfileSuccess({required this.company});

  @override
  List<Object?> get props => [company];
}

class CreateProfileFailure extends DefaultState {
  final String error;

  const CreateProfileFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
