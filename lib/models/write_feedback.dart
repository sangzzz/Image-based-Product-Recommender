import 'dart:io';
import 'package:path_provider/path_provider.dart';

Future<void> addToFile({
  String path,
  String appRecommendation,
  String suggestedRecommendation,
}) async {
  final Directory directory = await getApplicationDocumentsDirectory();
  final File _file = File('${directory.path}/my_file.txt');
  print(directory);
  Map<String, String> map = {
    "path": path,
    "appRecommendation": appRecommendation,
    'suggestedRecommendation': suggestedRecommendation,
  };
  await _file.writeAsString(map.toString());
}
