import 'light_state.dart';

class Light {
  final String _name;
  final String _type;
  final int _id;
  final LightState _state;
  final String _modelId;
  final String _uniqueId;
  final String _manufacturerName;
  final String _productName;
  final String _luminaireUniqueId;
  final String _swVersion;

  Light(
      this._name,
      this._type,
      this._id,
      this._state,
      this._modelId,
      this._uniqueId,
      this._manufacturerName,
      this._productName,
      this._luminaireUniqueId,
      this._swVersion);

  Light.fromJson(Map<String, dynamic> json)
      : _name = json["name"],
        _type = json["type"],
        _id = json["id"],
        _state = json["state"],
        _modelId = json["modelid"],
        _uniqueId = json["uniqueid"],
        _manufacturerName = json["manufacturername"],
        _productName = json["productname"],
        _luminaireUniqueId = json["luminaireuniqueid"],
        _swVersion = json["swversion"];

  String get swVersion => _swVersion;

  String get luminaireUniqueId => _luminaireUniqueId;

  String get productName => _productName;

  String get manufacturerName => _manufacturerName;

  String get uniqueId => _uniqueId;

  String get modelId => _modelId;

  LightState get state => _state;

  int get id => _id;

  String get type => _type;

  String get name => _name;

  @override
  String toString() {
    StringBuffer sb = new StringBuffer();
    sb
      ..writeln("Name: " + name)
      ..writeln("Type: " + _type)
      ..writeln("ID: " + _id.toString())
      ..writeln("\nState: \n" + _state.toString())
      ..writeln("Model ID: " + _modelId)
      ..writeln("Unique ID: " + _uniqueId)
      ..writeln("Manufacturer name: " + _manufacturerName)
      ..writeln("Product name: " + _productName)
      ..writeln("Luminaire Unique ID: " + _swVersion);

    return sb.toString();
  }
}
