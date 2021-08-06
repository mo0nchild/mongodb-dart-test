import 'package:mongo_dart/mongo_dart.dart';
import 'dart:io';
import 'package:path/path.dart' as path;

Future<void> gridfs_test(String filename, Db db) async {
  var inputStream = File('$filename/user.png').openRead();
  var gridFS = GridFS(db);
  var input = gridFS.createFile(inputStream, 'my_image.png');
  await await input
      .save()
      .then((value) => gridFS.getFile('my_image.png'))
      .then((value) => value?.writeToFilename('$filename/shit_out.png'));

  return;
}

Future<void> MongoDB(String URL) async {
  var db = Db(URL);
  await db.open(secure: true);
  print('opened');

  var coll = db.collection('items');
  var arr = await coll.find(where.sortBy('name').skip(0).limit(25)).toList();

  var dir = path.dirname(path.fromUri(Platform.script));
  await gridfs_test(dir, db);

  print(arr[0]);
  return;
}

void main(List<String> arguments) async {
  const database_url = '';
  await MongoDB(database_url).then((balue) => exit(0));
}
