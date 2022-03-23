import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart';

import 'websocket/mongodb/connect_to_db.dart';
import 'websocket/mongodb/database.dart';
import 'websocket/chat_handler.dart';

String _hostname = "0.0.0.0";
int _defaultPort = 9999;

void main() async {
  await connectToDb();
  final app = Router();

  // route for handling websocket (chat functionality)
  app.get('/', chatHandler);

  // route for getting user info
  // (only customer right now but can also be driver in future)
  app.get("/user/<id>", (Request request) {
    // graph ql call to get customer's ID
    String userID = request.params["id"].toString();
  });

  var portEnv = Platform.environment['PORT'];
  var port = portEnv == null ? _defaultPort : int.parse(portEnv);

  shelf_io.serve(app, _hostname, port).then((server) {
    print('Serving at ws://${server.address.host}:${server.port}');
  });

  // if process is killed, disconnect from db first
  ProcessSignal.sigint.watch().listen((event) async {
    print("closing...");
    await database.close();
    exit(0);
  });
}
