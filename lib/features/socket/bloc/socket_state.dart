import 'package:equatable/equatable.dart';

abstract class SocketState extends Equatable {
  const SocketState();

  @override
  List<Object> get props => [];
}

class SocketInitial extends SocketState {}

class SocketError extends SocketState {
  final String errorMessage;

  const SocketError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
