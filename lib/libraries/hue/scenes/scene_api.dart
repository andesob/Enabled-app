import 'package:enabled_app/libraries/hue/main/bridge.dart';
import 'package:enabled_app/libraries/hue/scenes/scene.dart';

class SceneApi{
  Bridge _bridge;
  String _username = 'oDvEKoVrvzzHpKgOuXSZGvueCn2fSE-snTpYayfg';

  SceneApi(this._bridge, [this._username]);

  String get username => _username;

  Bridge get bridge => _bridge;

  Future<List<Scene>> getAll() async{
    String url = '/api/' + _username + "/scenes";
    final response = await _bridge.get(url);
    final scenes = <Scene> [];
    for (String id in response.keys){
      Map<String, dynamic> item = response[id];
      final scene = Scene.fromJson(item, id);
      scenes.add(scene);
    }

    return scenes;
  }


}