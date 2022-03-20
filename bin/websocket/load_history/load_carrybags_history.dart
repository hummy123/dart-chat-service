import 'package:mongo_dart/mongo_dart.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../mongodb/database.dart';
import '../send_message.dart';

void loadCarryBagsHistory(WebSocketChannel webSocket) async {
  // retrieve history from mongo db
  // in ascending (1, 2, 3) order
  List<Map<String, dynamic>> history = await collection
      .find(
        where.sortBy("timestamp"),
      )
      .toList();

  // add history to connected client
  for (var message in history) {
    sendMessage(webSocket, message);
  }
}
