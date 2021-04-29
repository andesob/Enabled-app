import 'package:flutter/material.dart';

class NeedsObject {
  final String _text;
  final IconData _icon;

  const NeedsObject(this._text, this._icon);

  IconData get icon => _icon;

  String get text => _text;
}
