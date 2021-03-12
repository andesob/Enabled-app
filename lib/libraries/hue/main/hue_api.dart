import 'package:enabled_app/libraries/hue/groups/group.dart';
import 'package:enabled_app/libraries/hue/lights/light.dart';
import 'package:enabled_app/libraries/hue/lights/light_state.dart';
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
        print("IP: " + bridgeFinderResult.ip);
        print("USERNAME: " + user.username);
      }
    }

    if (user != null) {
      lights = await getLights();
      scenes = await getScenes();
      groups = await getGroups();
      setCurrentGroup(groups.first.name);
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

  void powerOnAll(){
    _setPower(true);
  }

  void powerOffAll(){
    _setPower(false);
  }

  Future<void> _setPower(bool on) async {
    if (bridgeApi != null) {
      if (lights == null) {
        lights = await bridgeApi.getLights();
      }

      for (Light l in lights) {
        LightState state = l.state;
        state.on = on;

        await bridgeApi.updateLightState(l.id, state);
      }
      updateAll();
    }
  }

  void changeScene(String sceneId){
    if(bridgeApi != null){
      bridgeApi.changeScene(sceneId, currentGroup.id);
    }
  }

  void brightnessDown(){
    int brightness = lights.first.state.brightness - 50;
    if(brightness < 0){
      brightness = 0;
    }

    _setBrightness(brightness);
  }

  void brightnessUp(){
    int brightness = lights.first.state.brightness + 50;
    if(brightness > 254){
      brightness = 254;
    }

    _setBrightness(brightness);
  }

  Future<void> _setBrightness(int brightness) async {
    if (bridgeApi != null){
      for(Light l in lights){
        LightState state = l.state;
        state.brightness = brightness;

        await bridgeApi.updateLightState(l.id, state);
      }
    }
    updateAll();
  }

  void setCurrentGroup(String name) {
    for (Group g in groups) {
      if (g.name == name) {
        currentGroup = g;
        break;
      }
    }
  }

  Future<void> updateAll() async {
    lights = await getLights();
    scenes = await getScenes();
    groups = await getGroups();
    setCurrentGroup(groups.first.name);
  }
}
