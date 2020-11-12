import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';

Future<void> addToFile({
  String path,
  String appRecommendation,
  String suggestedRecommendation,
}) async {
  await Firebase.initializeApp();
  final Directory directory = await getApplicationDocumentsDirectory();
  final File _file = File('${directory.path}/my_file.txt');
  Map<String, String> map = {
    "appRecommendation": appRecommendation,
    'suggestedRecommendation': suggestedRecommendation,
  };
  await _file.writeAsString(map.toString());
  String uploadName = DateTime.now().toString();
  final File _image = File(path);
  try {
    FirebaseStorage.instance.ref().child(uploadName + '.png').putFile(_image);
    FirebaseStorage.instance.ref().child(uploadName + '.txt').putFile(_file);
  } on FirebaseException catch (e) {
    print(e);
  }
}
