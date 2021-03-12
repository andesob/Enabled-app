import 'package:enabled_app/libraries/hue/groups/group.dart';
import 'package:enabled_app/libraries/hue/lights/light.dart';
import 'package:enabled_app/libraries/hue/main/BridgeFinderResult.dart';
import 'package:enabled_app/libraries/hue/main/bridge_api.dart';
import 'package:enabled_app/libraries/hue/main/bridge_finder.dart';
import 'package:enabled_app/libraries/hue/main/user.dart';
import 'package:enabled_app/libraries/hue/scenes/scene.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HueApi {
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

    List<BridgeFinderResult> bridgeFinderResults =
        await bridgeFinder.automatic();
    bridgeFinderResult = bridgeFinderResults.first;
    bridgeApi = BridgeApi(client, bridgeFinderResult.ip);

    pref = await SharedPreferences.getInstance();

    String username = await pref.get("username");
    if (username != null) {
      if (username.isNotEmpty) {
        user = new User(username);
        bridgeApi.username = username;
      }
    }

    if (user != null) {
      lights = await getLights();
      scenes = await getScenes();
      groups = await getGroups();
    }
  }

  Future<void> createUser(username) async {
    if (bridgeApi != null) {
      final response = await bridgeApi.createUser(username);
      if (response.keys.first == "success") {
        final success = response["success"];
        print(success.toString());

        user = new User(success["username"]);
        bridgeApi.username = user.username;

        await pref.setString("username", user.username);
      } else if (response.keys.first == "error") {
        final error = response["error"];
        print(error.toString());
      }
    } else {
      print("No bridge found");
    }
  }

  Future<List<Light>> getLights() async {
    List<Light> list;
    if (bridgeApi != null && user != null) {
      list = await bridgeApi.getLights();
    }

    return list;
  }

  Future<List<Scene>> getScenes() async {
    List<Scene> list;
    if (bridgeApi != null && user != null) {
      list = await bridgeApi.getScenes();
    }

    return list;
  }

  Future<List<Group>> getGroups() async {
    List<Group> list;
    if (bridgeApi != null && user != null) {
      list = await bridgeApi.getGroups();
    }

    return list;
  }
}
