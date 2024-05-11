import 'package:equatable/equatable.dart';

abstract class DefaultEvent extends Equatable {
  const DefaultEvent();

  @override
  List<Object> get props => [];
}

class GetAllTechStack extends DefaultEvent {}

class GetAllSkillSet extends DefaultEvent {}
