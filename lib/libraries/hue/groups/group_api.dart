import 'package:enabled_app/libraries/hue/groups/group.dart';
import 'package:enabled_app/libraries/hue/main/bridge.dart';

class GroupApi {
  Bridge _bridge;
  String _username = 'oDvEKoVrvzzHpKgOuXSZGvueCn2fSE-snTpYayfg';

  GroupApi(this._bridge, [this._username])

  String get username => _username;

  Bridge get bridge => _bridge;

  Future<List<Group>> getAll() async {
    String url = '/api' + _username + '/groups';
    final response = await _bridge.get(url);
    final groups = <Group> [];
    for(String id in response.keys){
      Map<String, dynamic> groupMap = response[id];
      final group = Group.fromJson(groupMap, id);
      groups.add(group);
    }
    return groups;
  }
}