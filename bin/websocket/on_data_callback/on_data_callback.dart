import 'dart:convert';

import 'package:web_socket_channel/web_socket_channel.dart';

import 'handle_connect.dart';
import 'handle_message.dart';

void onDataCallback(message, WebSocketChannel webSocket) {
  try {
    // convert string to map object
    Map<String, dynamic> data = jsonDecode(message);

    // if there is a connect key (which means set up),
    // then get id and add to our list of clients
    if (data.containsKey("connect")) {
      handleConnect(webSocket, data);
    }
    // if there is a room key, then this is a chat message.
    else if (data.containsKey("room")) {
      handleMessage(data);
    }
  } catch (err) {
    print(err);
  }
}
