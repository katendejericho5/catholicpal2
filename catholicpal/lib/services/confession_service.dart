import 'dart:io';
import 'dart:convert';
import 'package:catholicpal/models/confession_model.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:flutter/services.dart' show rootBundle;

class DataService {
  static const String _fileName = 'assets/confession_qn.json';

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }
String sampleData = '''
{
  "lifeStageCategories": [
    {
      "name": "Youth",
      "areas": [
        {
          "name": "Faith",
          "checkpoints": [
            {"question": "Do you pray daily?", "isChecked": false}
          ]
        }
      ]
    }
  ]
}
''';

Future<List<LifeStageCategory>> loadData() async {
  print('Using sample data...');
  final jsonResult = json.decode(sampleData);
  return (jsonResult['lifeStageCategories'] as List)
      .map((category) => LifeStageCategory.fromJson(category))
      .toList();
}

  Future<File> get _localFile async {
    final path = await _localPath;
    print('Local file path: $path/$_fileName');
    return File('$path/$_fileName');
  }

  // Future<List<LifeStageCategory>> loadData() async {
  //   try {
  //     final file = await _localFile;
  //     if (await file.exists()) {
  //       String contents = await file.readAsString();
  //       final jsonResult = json.decode(contents);
  //       return (jsonResult['lifeStageCategories'] as List)
  //           .map((category) => LifeStageCategory.fromJson(category))
  //           .toList();
  //     } else {
  //       // If the file doesn't exist, load the initial data from the asset
  //       String initialData = await rootBundle.loadString('assets/$_fileName');
  //       await file.writeAsString(initialData); // Save the initial data
  //       final jsonResult = json.decode(initialData);
  //       print(jsonResult);
  //       return (jsonResult['lifeStageCategories'] as List)
  //           .map((category) => LifeStageCategory.fromJson(category))
  //           .toList();
  //     }
  //   } catch (e) {
  //     print('Error loading data: $e');
  //     return [];
  //   }
  // }

  Future<void> saveData(List<LifeStageCategory> categories) async {
    try {
      final file = await _localFile;
      final data = {
        'lifeStageCategories':
            categories.map((category) => category.toJson()).toList(),
      };
      await file.writeAsString(json.encode(data));
    } catch (e) {
      print('Error saving data: $e');
    }
  }

  Future<void> updateCheckpoint(String lifeStageName, String areaName,
      String questionText, bool isChecked) async {
    List<LifeStageCategory> categories = await loadData();
    for (var category in categories) {
      if (category.name == lifeStageName) {
        for (var area in category.areas) {
          if (area.name == areaName) {
            for (var checkpoint in area.checkpoints) {
              if (checkpoint.question == questionText) {
                checkpoint.isChecked = isChecked;
                await saveData(categories);
                return;
              }
            }
          }
        }
      }
    }
  }

  Future<void> clearAllCheckpoints() async {
    List<LifeStageCategory> categories = await loadData();
    for (var category in categories) {
      for (var area in category.areas) {
        for (var checkpoint in area.checkpoints) {
          checkpoint.isChecked = false;
        }
      }
    }
    await saveData(categories);
  }
}
