import 'package:enabled_app/libraries/hue/groups/group_action.dart';
import 'package:enabled_app/libraries/hue/groups/group_state.dart';
import 'package:enabled_app/libraries/hue/lights/light.dart';

class Group {
  final String _id;
  final String _type;
  final String _name;
  final List<int> _lights;
  final GroupState _state;
  final GroupAction _action;

  Group(this._id, this._type, this._name, this._lights, this._state,
      this._action);

  Group.fromJson(Map<String, dynamic> json, this._id)
      : _type = json["type"],
        _name = json["name"],
        _lights = json["lights"],
        _state = GroupState.fromJson(json),
        _action = GroupAction.fromJson(json);
}
