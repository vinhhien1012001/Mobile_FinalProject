import 'package:equatable/equatable.dart';

abstract class SocketEvent extends Equatable {
  const SocketEvent();

  @override
  List<Object> get props => [];
}

class ConnectSocket extends SocketEvent {}

class DisconnectSocket extends SocketEvent {}

class SendMessage extends SocketEvent {
  final String message;

  const SendMessage(this.message);

  @override
  List<Object> get props => [message];
}

class ReceiveMessage extends SocketEvent {
  final dynamic data;

  const ReceiveMessage(this.data);

  @override
  List<Object> get props => [data];
}

class SocketError extends SocketEvent {
  final dynamic error;

  const SocketError(this.error);

  @override
  List<Object> get props => [error];
}
