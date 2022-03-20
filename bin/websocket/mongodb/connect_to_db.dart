// function that connects to db
import 'dart:io';

import 'package:mongo_dart/mongo_dart.dart';

import 'database.dart';

Future<void> connectToDb() async {
  final connection = Platform.environment["MONGODB_URI"].toString();
  try {
    database = await Db.create(connection);
    await database.open();
    collection = database.collection("ChatModel");
  } catch (err) {
    print(err);
    print("An error occurred! Did you remember to set the MONGODB_URI environment variable?");
  }
}
