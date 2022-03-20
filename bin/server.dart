import 'dart:io';

import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_web_socket/shelf_web_socket.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'websocket/mongodb/connect_to_db.dart';
import 'websocket/mongodb/database.dart';
import 'websocket/on_data_callback/on_data_callback.dart';
import 'websocket/on_done_callback/on_done_callback.dart';

void main() async {
  // connect to database
  await connectToDb();

  // handler function to deal with websockets
  var handler = webSocketHandler((WebSocketChannel webSocket) {
    webSocket.stream.listen(
      (message) {
        // callback when we receive some data
        onDataCallback(message, webSocket);
      },
      // callback when client disconnects
      onDone: () => onDoneCallback(webSocket),
    );
  });

  var portEnv = Platform.environment['PORT'];
  var port = portEnv == null ? 9999 : int.parse(portEnv);

  shelf_io.serve(handler, 'localhost', port).then((server) {
    print('Serving at ws://${server.address.host}:${server.port}');
  });

  // if process is killed, disconnect from db first
  ProcessSignal.sigint.watch().listen((event) async {
    print("closing...");
    await database.close();
    exit(0);
  });
}
