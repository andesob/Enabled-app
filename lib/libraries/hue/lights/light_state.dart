class LightState {
  final bool _on;
  final int _brightness;
  final int _hue;
  final int _saturation;
  final int _xy;

  final int _ct;
  final String _alert;
  final String _effect;
  final String _colormode;
  final bool _reachable;

  LightState(this._on, this._brightness, this._hue, this._saturation, this._xy, this._ct,
      this._alert, this._effect, this._colormode, this._reachable);

  bool get reachable => _reachable;

  String get colormode => _colormode;

  String get effect => _effect;

  String get alert => _alert;

  int get xy => _xy;

  int get ct => _ct;

  int get saturation => _saturation;

  int get hue => _hue;

  int get brightness => _brightness;

  bool get on => _on;

  @override
  String toString() {
    StringBuffer sb = new StringBuffer();
    sb
      ..writeln("On: " + _on.toString())
      ..writeln("Brightness: " + _brightness.toString())
      ..writeln("Hue: " + _hue.toString())
      ..writeln("Saturation: " + _saturation.toString())
      ..writeln("XY: " + _xy.toString())
      ..writeln("CT: " + _ct.toString())
      ..writeln("Alert: " + _alert)
      ..writeln("Effect: " + _effect)
      ..writeln("Colormode: " + _colormode)
      ..writeln("Reachable: " + _reachable.toString());
    return sb.toString();
  }
}
