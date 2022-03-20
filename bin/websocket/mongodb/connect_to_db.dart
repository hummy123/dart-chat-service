// function that connects to db
import 'dart:io';

import 'package:mongo_dart/mongo_dart.dart';

import '../on_data_callback/handle_message.dart';
import 'database.dart';

Future<void> connectToDb() async {
  final connection = Platform.environment["MONGODB_URI"].toString();
  try {
    database = await Db.create(connection);
    await database.open();
    collection = database.collection("ChatModel");

    // listen to inserts
    Stream newMessageStream = collection.watch(<Map<String, Object>>[
      {
        '\$match': {'operationType': 'insert'}
      }
    ]);
    newMessageStream.listen((event) {
      handleMessage(event.fullDocument);
    });
  } catch (err) {
    print(err);
    print("An error occurred! Did you remember to set the MONGODB_URI environment variable?");
  }
}
