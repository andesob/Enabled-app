import 'package:flutter/material.dart';

/// A object in the needs categor. Contains an object string and an icon.
class NeedsObject {
  /// The object string.
  final String _text;

  /// The icon of the object.
  final IconData _icon;

  const NeedsObject(this._text, this._icon);

  /// Returns the object icon.
  IconData get icon => _icon;

  /// Returns the object text.
  String get text => _text;
}
