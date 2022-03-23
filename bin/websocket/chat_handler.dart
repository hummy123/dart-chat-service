import 'package:shelf_web_socket/shelf_web_socket.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'on_data_callback/on_data_callback.dart';
import 'on_done_callback/on_done_callback.dart';

var chatHandler = webSocketHandler((WebSocketChannel webSocket) {
  webSocket.stream.listen(
    // callback when we receive some data
    (message) => onDataCallback(message, webSocket),

    // callback when client disconnects
    onDone: () => onDoneCallback(webSocket),
  );
});
