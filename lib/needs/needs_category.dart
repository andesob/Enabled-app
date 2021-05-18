import 'package:enabled_app/needs/needs.dart';

import 'needs_object.dart';

/// The need category represents a category in the [NeedsPage].
/// Contains a category name and a list of the objects in the category.
class NeedsCategory {
  /// The category name.
  final String _categoryName;

  /// The list containing the category objects.
  final List<NeedsObject> _categoryObjects;

  NeedsCategory(this._categoryName, this._categoryObjects);

  /// Returns the category name.
  String get name {
    return this._categoryName;
  }

  /// Returns the category objects.
  List<NeedsObject> get objects {
    return this._categoryObjects;
  }
}
