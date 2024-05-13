import 'package:equatable/equatable.dart';
import 'package:final_project_mobile/models/student.dart';
import 'package:final_project_mobile/models/user_profile.dart';

abstract class DefaultEvent extends Equatable {
  const DefaultEvent();

  @override
  List<Object> get props => [];
}

class GetAllTechStack extends DefaultEvent {}

class GetAllSkillSet extends DefaultEvent {}

class UpdateProfile extends DefaultEvent {
  final String studentId;
  final String techStackId;
  final List<SkillSet> skillSets;

  const UpdateProfile(
      {required this.studentId,
      required this.techStackId,
      required this.skillSets});

  @override
  List<Object> get props => [studentId, techStackId, skillSets];
}

class CreateCompanyProfile extends DefaultEvent {
  final Company company;

  const CreateCompanyProfile({required this.company});

  @override
  List<Object> get props => [company];
}
