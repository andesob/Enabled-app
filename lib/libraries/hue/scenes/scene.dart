class Scene {
  final String _id;
  final String _name;
  final String _type;
  final String _group;
  final List<int> _lights;
  final String _owner;
  final bool _recycle;
  final bool _locked;
  final String _lastUpdated;
  final int _version;

  Scene(
      this._id,
      this._name,
      this._type,
      this._group,
      this._lights,
      this._owner,
      this._recycle,
      this._locked,
      this._lastUpdated,
      this._version);

  int get version => _version;

  String get lastUpdated => _lastUpdated;

  bool get locked => _locked;

  bool get recycle => _recycle;

  String get owner => _owner;

  List<int> get lights => _lights;

  String get group => _group;

  String get type => _type;

  String get name => _name;

  String get id => _id;

  @override
  String toString() {
    StringBuffer sb = new StringBuffer();
    sb
    ..writeln("id: " + _id)
    ..writeln("name: " + _name)
    ..writeln("type: " + _type)
    ..writeln("group: " + _group)
    ..writeln("lights: " + _lights.toString())
    ..writeln("owner: " + _owner)
    ..writeln("recycle: " + _recycle.toString())
    ..writeln("locked: " + _locked.toString())
    ..writeln("lastupdated: " + _lastUpdated)
    ..writeln("version: " + _version.toString());
  }
}
