import 'package:web_socket_channel/web_socket_channel.dart';

import '../connected_clients.dart';
import '../load_history/load_carrybags_history.dart';
import '../load_history/load_customer_history.dart';

// this function handles new websocket connections
void handleConnect(WebSocketChannel webSocket, Map data) {
  String id = data["connect"];

  // if list of clients does not contain this id,
  // then create new array,
  if (!clients.containsKey(id)) {
    clients[id] = [];
  }

  clients[id]?.add(webSocket);

  if (id == "carrybags") {
    loadCarryBagsHistory(webSocket);
  } else {
    loadCustomerHistory(webSocket, id);
  }
}
