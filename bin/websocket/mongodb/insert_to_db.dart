import 'database.dart';

Future<void> insertToDb(Map<String, dynamic> object) async {
  try {
    await collection.insertOne(object);
  } catch (err) {
    print(err);
  }
}
