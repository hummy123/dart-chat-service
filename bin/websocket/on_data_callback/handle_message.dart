import '../connected_clients.dart';
import '../mongodb/insert_to_db.dart';
import '../send_message.dart';

// this function handles messages received from websockets
void handleMessage(Map<String, dynamic> data) async {
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

  // Note: timestamp being a date object
  // allows us to sort by date on mongodb.
  // So we convert it to DateTime if it is not already.
  Map<String, dynamic> dbObject = data;
  if (dbObject["timestamp"] is String) {
    dbObject["timestamp"] = DateTime.parse(dbObject["timestamp"]);
  }
  await insertToDb(dbObject);
}
