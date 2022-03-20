import 'package:web_socket_channel/web_socket_channel.dart';

import '../connected_clients.dart';
import '../mongodb/insert_to_db.dart';
import '../send_message.dart';

// this function handles messages received from websockets
void handleMessage(WebSocketChannel webSocket, Map<String, dynamic> data) async {
  // Iterate over list.
  String room = data["room"];

  // iterate over each of these users and send message to all
  clients[room]?.forEach((user) {
    sendMessage(user, data);
  });

  // also iterate over all users who are carrybags representatives
  // since they should receive all messages too.
  clients["carrybags"]?.forEach((staff) {
    sendMessage(staff, data);
  });

  // Save message to db.
  // Note: timestamp being a date object
  // allows us to sort by date on mongodb.
  // So we convert it to DateTime if it is not already.
  await insertToDb({
    ...data,
    "timestamp": DateTime.parse(data["timestamp"]),
  });
}