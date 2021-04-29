import 'needs_object.dart';

class NeedsCategory {
  final String _categoryName;
  final List<NeedsObject> _categoryObjects;

  NeedsCategory(this._categoryName, this._categoryObjects);

  String get name {
    return this._categoryName;
  }

  List<NeedsObject> get objects {
    return this._categoryObjects;
  }
}
