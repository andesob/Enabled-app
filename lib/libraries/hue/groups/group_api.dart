import 'dart:convert';

import 'package:enabled_app/libraries/hue/groups/group.dart';
import 'package:enabled_app/libraries/hue/main/bridge.dart';

class GroupApi {
  Bridge _bridge;
  String _username;

  GroupApi(this._bridge, [this._username]);

  String get username => _username;

  Bridge get bridge => _bridge;


  set username(String value) {
    _username = value;
  }

  Future<List<Group>> getAll() async {
    String url = '/api/' + _username + '/groups';
    final response = await _bridge.get(url);
    final groups = <Group> [];
    for(String id in response.keys){
      Map<String, dynamic> groupMap = response[id];
      final group = Group.fromJson(groupMap, id);
      groups.add(group);
    }
    return groups;
  }
  
  Future<void> changeScene(String sceneId, String groupId) async {
    String url = '/api/' + _username + '/groups/' + groupId + '/action';
    final response = await _bridge.put(url, {'scene': sceneId});
    print(response[0]);
  }
}