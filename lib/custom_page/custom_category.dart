class CustomCategory {
  final String _categoryName;
  final List<String> _categoryObjects;

  CustomCategory(this._categoryName, this._categoryObjects);

  String get name {
    return this._categoryName;
  }

  List<String> get objects {
    return this._categoryObjects;
  }
}
