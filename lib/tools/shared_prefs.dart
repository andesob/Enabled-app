import 'package:shared_preferences/shared_preferences.dart';

/// A static class for retrieving and saving information in the sharedPreference.
class SharedPrefs {
  static SharedPreferences _sharedPrefs;

  factory SharedPrefs() => SharedPrefs._internal();

  SharedPrefs._internal();

  Future<void> init() async {
    _sharedPrefs ??= await SharedPreferences.getInstance();
  }

  /// An example on how to get Strings from the shared prefs.
  String get customCategories {
    String customCategories = _sharedPrefs.getString(keyCustomCategories) ?? "";
    return customCategories;
  }

  /// An example on how to store a string in the shared prefs.
  set setCategories(String value) =>
      _sharedPrefs.setString(keyCustomCategories, value);
}

final sharedPrefs = SharedPrefs();

// TODO - Make generic function call and move keys to static string class??
const String keyCustomCategories = "keykeykey";
