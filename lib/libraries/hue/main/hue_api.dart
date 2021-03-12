import 'package:enabled_app/libraries/hue/groups/group.dart';
import 'package:enabled_app/libraries/hue/lights/light.dart';
import 'package:enabled_app/libraries/hue/main/BridgeFinderResult.dart';
import 'package:enabled_app/libraries/hue/main/bridge_api.dart';
import 'package:enabled_app/libraries/hue/main/bridge_finder.dart';
import 'package:enabled_app/libraries/hue/main/user.dart';
import 'package:enabled_app/libraries/hue/scenes/scene.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HueApi{
  static final HueApi _api = HueApi._internal();
  final client = Client();

  BridgeFinder bridgeFinder;
  BridgeFinderResult bridgeFinderResult;
  BridgeApi bridgeApi;
  User user;
  List<Light> lights;
  List<Scene> scenes;
  List<Group> groups;

  Group currentGroup;
  Scene currentScene;

  SharedPreferences pref;

  factory HueApi() {
    return _api;
  }

  HueApi._internal();

  Future<void> findBridge() async {
    bridgeFinder = BridgeFinder(client);

    List<BridgeFinderResult> bridgeFinderResults = await bridgeFinder.automatic();
    bridgeFinderResult = bridgeFinderResults.first;

    bridgeApi = BridgeApi(client, bridgeFinderResult.ip);

    pref = await SharedPreferences.getInstance();

    String username = await pref.get("username");
    if(username != null){
      if(username.isNotEmpty){
        user = new User(username);
        bridgeApi.username = username;
      }
    }

    if (user != null){

    }
  }

  void createUser(username){
    if(bridgeApi != null){

    }
  }
}