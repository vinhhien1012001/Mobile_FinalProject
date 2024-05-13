// ignore_for_file: avoid_print
// ignore_for_file: library_prefixes

import 'dart:developer';

import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  late IO.Socket socket;

  void initSocket(
      {required String baseUrl,
      required String token,
      required int projectId}) {
    socket = IO.io(
      baseUrl,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build(),
    );

    // Add authorization to header
    socket.io.options?['extraHeaders'] = {
      'Authorization': 'Bearer $token',
    };

    // Add query param to URL
    socket.io.options?['query'] = {
      'project_id': projectId,
    };

    socket.connect();

    socket.onConnect((_) {
      log('Connected');
      print('Connected');
    });

    socket.onDisconnect((_) {
      log('DisConnected');
      print('Disconnected');
    });
  }

  void sendMessage(Map<String, dynamic> message) {
    socket.emit('SEND_MESSAGE', message);
  }

  void dispose() {
    socket.disconnect();
  }
}
