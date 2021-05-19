import 'package:uuid/uuid.dart';

/// Class containing category information.
///
/// Used by the custom page to keep track of categories added
class CustomCategory {
  /// The name of the category
  final String categoryName;

  /// [List] containing all instances of [String] in this [CustomCategory]
  final List<String> categoryObjects;

  /// Unique ID of category
  String _categoryId = Uuid().v4();

  CustomCategory({
    this.categoryName,
    this.categoryObjects,
  });

  /// Generates [CustomCategory] from json.
  ///
  /// Useful when storing information using [SharedPreferences].
  CustomCategory.fromJson(Map<String, dynamic> json)
      : categoryName = json['categoryName'],
        categoryObjects = json['categoryObjects'].cast<String>(),
        _categoryId = json['categoryId'];

  /// Converts [CustomCategory] to json
  ///
  /// Useful when storing information using [SharedPreferences].
  Map<String, dynamic> toJson() {
    return {
      'categoryName': this.categoryName,
      'categoryObjects': this.categoryObjects,
      'categoryId': this._categoryId
    };
  }

  /// The name of this category.
  String get name {
    return this.categoryName;
  }

  /// The [List] of [String] objects in this category.
  List<String> get objects {
    return this.categoryObjects;
  }

  /// The unique ID of this category.
  String get categoryId => _categoryId;
}
