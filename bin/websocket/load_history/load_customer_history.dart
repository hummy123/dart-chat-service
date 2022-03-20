import 'package:mongo_dart/mongo_dart.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../mongodb/database.dart';
import '../send_message.dart';

void loadCustomerHistory(WebSocketChannel webSocket, String id) async {
  // retrieve history from mongo db,
  // in ascending (1, 2, 3) order
  // and where room field is id
  List<Map<String, dynamic>> history = await collection
      .find(
        where.eq("room", id).sortBy("timestamp"),
      )
      .toList();

  // add history to connected client
  for (var message in history) {
    sendMessage(webSocket, message);
  }
}
