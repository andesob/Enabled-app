class CustomCategory {
  String categoryName;
  List<String> objects;

  CustomCategory({this.categoryName, this.objects});

  String get name {
    return this.categoryName;
  }

  List<String> get allObjects {
    return this.objects;
  }
}
