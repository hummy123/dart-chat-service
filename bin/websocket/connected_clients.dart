import 'package:web_socket_channel/web_socket_channel.dart';

// map to keep track of connected users
Map<String, List<WebSocketChannel>> clients = {};
