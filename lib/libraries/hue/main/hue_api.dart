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
import 'dart:developer' as developer;

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

  Future<bool> setup() async {
    pref = await SharedPreferences.getInstance();

    BridgeFinderResult bridgeResult = await findBridge();
    if(bridgeResult == null) return false;

    User foundUser = await _findUser();
    if (foundUser == null) return false;

    lights = await getLights();
    scenes = await getScenes();
    groups = await getGroups();
    setCurrentGroup(groups.first.name);
    return true;
  }

  Future<BridgeFinderResult> findBridge() async {
    bridgeFinder = BridgeFinder(client);

    List<BridgeFinderResult> bridgeFinderResultList =
        await bridgeFinder.automatic();

    if (bridgeFinderResultList.isEmpty) {
      developer.log("No bridges found");
      return null;
    }

    bridgeFinderResult = bridgeFinderResultList.first;
    developer.log("HUE bridge found with IP: " + bridgeFinderResult.ip);
    bridgeApi = BridgeApi(client, bridgeFinderResult.ip);

    return bridgeFinderResult;
  }

  Future<User> _findUser() async {
    String username = await pref.get("username");
    if (username != null) {
      if (username.isNotEmpty) {
        user = new User(username);
        bridgeApi.username = username;
        developer.log("Found username in prefs\nAdding user with username: " +
            username);
        return user;
      }
    }

    return _createUser("p30_pro");
  }

  Future<User> _createUser(username) async {
    final response = await bridgeApi.createUser(username);

    if (response.keys.first == "success") {
      final success = response["success"];
      developer.log("Successfully created user: " + success.toString());

      user = new User(success["username"]);
      bridgeApi.username = user.username;

      await pref.setString("username", user.username);
      return user;
    } else if (response.keys.first == "error") {
      final error = response["error"];
      if (error["type"] == 101) {
        developer.log(
            "Please press the button on your Philips HUE bridge and try again");
      } else {
        developer.log("Error creating user: " + error.toString());
      }
    }
    return null;
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

  void powerOnAll() {
    _setPower(true);
  }

  void powerOffAll() {
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

  void changeScene(String sceneId) {
    if (bridgeApi != null) {
      bridgeApi.changeScene(sceneId, currentGroup.id);
    }
  }

  void brightnessDown() {
    int brightness = lights.first.state.brightness - 50;
    if (brightness < 0) {
      brightness = 0;
    }

    _setBrightness(brightness);
  }

  void brightnessUp() {
    int brightness = lights.first.state.brightness + 50;
    if (brightness > 254) {
      brightness = 254;
    }

    _setBrightness(brightness);
  }

  Future<void> _setBrightness(int brightness) async {
    if (bridgeApi != null) {
      for (Light l in lights) {
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
