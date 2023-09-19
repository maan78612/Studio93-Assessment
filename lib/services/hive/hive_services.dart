import 'package:hive/hive.dart';

class HiveServices {
  static String boxName = "sol_replace";
  static String onBoardStatus = "onBoardStatus";
  static var solReplaceHiveBox;

  static openBox(String boxName) async {
    solReplaceHiveBox = await Hive.openBox(boxName);
  }

  static insertString(String key, String value) async {
    deleteString(key);
    solReplaceHiveBox.put(key, value);

  }

  static Future<String?> getString(String key) async {
    return solReplaceHiveBox.get(key);
  }

  static deleteString(String key) async {
    solReplaceHiveBox.delete(key);
  }
}
