import 'package:flutter/material.dart';

class NeedsObject {
  final String _text;
  final Icon _icon;

  const NeedsObject(this._text, this._icon);

  Icon get icon => _icon;

  String get text => _text;
}
