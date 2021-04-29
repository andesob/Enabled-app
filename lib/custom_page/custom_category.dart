import 'package:uuid/uuid.dart';

class CustomCategory {
  final String categoryName;
  final List<String> categoryObjects;
  String _categoryId = Uuid().v4();

  CustomCategory({this.categoryName, this.categoryObjects});

  CustomCategory.fromJson(Map<String, dynamic> json)
      : categoryName = json['categoryName'],
        categoryObjects = json['categoryObjects'].cast<String>(),
        _categoryId = json['categoryId'];

  Map<String, dynamic> toJson(){
    return {
      'categoryName': this.categoryName,
      'categoryObjects': this.categoryObjects,
      'categoryId': this._categoryId
    };
  }

  String get name {
    return this.categoryName;
  }

  List<String> get objects {
    return this.categoryObjects;
  }

  String get categoryId => _categoryId;
}
