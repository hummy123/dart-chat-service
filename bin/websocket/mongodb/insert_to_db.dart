import 'database.dart';

Future<void> insertToDb(Map<String, dynamic> object) async {
  await collection.insertOne(object);
}
