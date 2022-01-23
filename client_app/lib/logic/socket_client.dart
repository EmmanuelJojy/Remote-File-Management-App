import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:client_app/data/shared.dart';
import 'package:client_app/models/connection.dart';

// ref: https://medium.com/flutter-community/working-with-sockets-in-dart-15b443007bc9

class SocketClient {
  final Connection c;
  Socket? soc;
  SocketClient(this.c);

  Socket get socket {
    return soc as Socket;
  }

  Future<bool> connect() async {
    try {
      soc = await Socket.connect(c.ip, int.parse(c.port))
          .timeout(const Duration(seconds: 2));
      await sendMessage(c.id);
      return true;
    } catch (e) {
      return false;
    }
  }

  void disconnect() async {
    await sendMessage('end');
    socket.destroy();
  }

  void shutdown() async {
    await sendMessage('shutdown');
    socket.destroy();
  }

  void _listen() {
    try {
      socket.listen(
        // handle data from the server
        (Uint8List data) {
          final serverResponse = String.fromCharCodes(data);
          SharedData.pool = serverResponse;
          log('Server Response: $serverResponse', time: DateTime.now());
        },
        // handle errors
        onError: (error) => socket.destroy(),
        // handle server ending connection
        onDone: () => socket.destroy(),
      );
    } catch (e) {
      log('Error caught at SocketClient._listen()', time: DateTime.now(), error: e);
    }
  }

  Future<void> sendMessage(String message, {bool listen = false}) async {
    socket.write(message);
    if (listen) {
      await Future.delayed(const Duration(milliseconds: 500));
      _listen();
    }
  }
}
