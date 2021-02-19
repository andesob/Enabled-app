import 'dart:convert';

import 'package:enabled_app/libraries/hue/lights/light.dart';
import 'package:enabled_app/libraries/hue/main/bridge.dart';

class LightApi{
  Bridge _bridge;
  String _username;

  LightApi(this._bridge, [this._username]);

  String get username => _username;

  Bridge get bridge => _bridge;

  Future<List<Light>> getAll() async {
    String url = "/api/" + _username + "/lights";
    final response = await _bridge.get(url);
    final lights = <Light> [];
    for(String id in response.keys){
      Map<String, dynamic> item = response[id];
      final light = Light.fromJson(item);
      lights.add(light);
    }

    return lights;
  }
}