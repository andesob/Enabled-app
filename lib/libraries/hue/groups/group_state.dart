class GroupState {
  final bool _anyOn;
  final bool _allOn;

  GroupState(this._anyOn, this._allOn);

  GroupState.fromJson(Map<String, dynamic> json)
      : _anyOn = json["any_on"],
        _allOn = json["all_on"];

  bool get allOn => _allOn;

  bool get anyOn => _anyOn;


  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = new Map();
    map["any_on"] = _anyOn;
    map["all_on"] = _allOn;
    return map;
  }

  @override
  String toString() {
    StringBuffer sb = new StringBuffer();
    sb
    ..writeln("any_on: " + _anyOn.toString())
    ..writeln("all_on: " + _allOn.toString());
    return sb.toString();
  }
}
