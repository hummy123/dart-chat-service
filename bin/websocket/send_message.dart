import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';

// just an abstraction to encode map objects as strng
// before sending them to a connection, to reduce code.
void sendMessage(WebSocketChannel webSocket, Map<String, dynamic> data) async {
  // for sending data,
  // timestamp must be string object.
  // So convert it to string if it is not already one.
  // (If it is already a string, no effect.)
  webSocket.sink.add(jsonEncode({
    ...data,
    "timestamp": data["timestamp"].toString(),
  }));
}
