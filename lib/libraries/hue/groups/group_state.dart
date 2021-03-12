class GroupState {
  final bool _anyOn;
  final bool _allOn;

  GroupState(this._anyOn, this._allOn);

  GroupState.fromJson(Map<String, dynamic> json)
      : _anyOn = json["any_on"],
        _allOn = json["all_on"];
}
