import 'package:easy_localization/easy_localization.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:take_me_with_you/core/utils/error_handler.dart';
import 'package:take_me_with_you/core/utils/function.dart';
import 'package:take_me_with_you/core/utils/socket_events.dart';

class SocketService {
  io.Socket? socket;
  bool isConnected = false;

  void connect() {
    socket = io.io(SocketEvents.baseUrl, <String, dynamic>{
      'transports': ['websocket'],
    });
    disconnect();
    socket!.connect();
    socket!.onDisconnect((_) {
      logPrint('onDisconnect');
      isConnected = false;
    });
    socket!.onConnect((_) {
      logPrint('onConnect');
      isConnected = true;
    });
    socket!.onConnectError((e) {
      logPrint('onConnectError $e');
      isConnected = false;
    });
    socket!.onConnect((_) => logPrint('onConnecting'));
  }

  void disconnect() {
    socket?.disconnect();
    socket?.close();
    socket?.destroy();
  }

  Future<void> send(String event, dynamic data) async {
    try {
      if (await noInternetConnection()) {
        logPrint(
            'socket $event $data Failed ${ResponseMessage.noInternetConnecting.tr()}');
      }
      if (!isConnected) {
        logPrint('socket $event $data Failed Connect to the Socket');
      }
      socket!.emit(event, data);
      logPrint('socket $event $data done');
    } catch (e) {
      logPrint('socket $event $data Failed $e');
    }
  }

  String getId() => socket?.id ?? '';

  void listen(String event, Function(dynamic) function) {
    logPrint('SocketService Listen $event');
    socket!.on(event, function);
  }
}
