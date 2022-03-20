import 'package:web_socket_channel/web_socket_channel.dart';

import '../connected_clients.dart';

void onDoneCallback(WebSocketChannel disconnectedClient) {
  clients.forEach((id, idList) {
    try {
      int index = idList.indexWhere((client) => client == disconnectedClient);
      idList.removeAt(index);
      if (idList.isEmpty) {
        clients.remove(idList);
      }
    } catch (err) {
      print(err);
    }
  });
}
