part of 'default_bloc.dart';

abstract class DefaultState extends Equatable {
  const DefaultState();

  @override
  List<Object?> get props => [];
}

class DefaultInitial extends DefaultState {}
