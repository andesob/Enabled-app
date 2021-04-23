import 'dart:convert';

import 'package:enabled_app/libraries/hue/lights/light.dart';
import 'package:enabled_app/libraries/hue/lights/light_state.dart';
import 'package:enabled_app/libraries/hue/main/bridge.dart';
import 'dart:developer' as developer;

class LightApi{
  Bridge _bridge;
  String _username;

  LightApi(this._bridge, [this._username]);

  String get username => _username;

  Bridge get bridge => _bridge;

  set username(String value) {
    _username = value;
  }

  Future<List<Light>> getAll() async {
    String url = '/api/' + _username + '/lights';
    final response = await _bridge.get(url);
    final lights = <Light> [];
    for(String id in response.keys){
      Map<String, dynamic> item = response[id];
      final light = Light.fromJson(item, id);
      lights.add(light);
    }

    return lights;
  }

  Future<void> updateState(String id, LightState state) async {
    String url = '/api/' + _username + '/lights/' + id.toString() + '/state';
    final response = await _bridge.put(url, state.toMap());
    developer.log("Updated light state: " + response[0]);
  }

}