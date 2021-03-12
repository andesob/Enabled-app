class BridgeFinderResult {
  final String _id;
  final String _ip;

  BridgeFinderResult(this._id, this._ip);

  BridgeFinderResult.fromJson(Map<String, dynamic> json)
      : _id = json["name"],
        _ip = json["type"];

  String get ip => _ip;

  String get id => _id;
}
