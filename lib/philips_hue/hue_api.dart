import 'package:enabled_app/philips_hue/hue_results.dart';
import 'package:http/http.dart';
import 'package:philips_hue_flutter_library/hue/groups/group.dart';
import 'package:philips_hue_flutter_library/hue/lights/light.dart';
import 'package:philips_hue_flutter_library/hue/lights/light_state.dart';
import 'package:philips_hue_flutter_library/hue/main/bridge_api.dart';
import 'package:philips_hue_flutter_library/hue/main/bridge_finder.dart';
import 'package:philips_hue_flutter_library/hue/main/bridge_finder_result.dart';
import 'package:philips_hue_flutter_library/hue/main/user.dart';
import 'package:philips_hue_flutter_library/hue/scenes/scene.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as developer;

class HueApi {
  static final HueApi _api = HueApi._internal();
  Client client;

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

  factory HueApi(Client client) {
    _api.client = client;
    return _api;
  }

  HueApi._internal();

  Future<HueResults> setup() async {
    pref = await SharedPreferences.getInstance();

    BridgeFinderResult bridgeResult = await findBridge();
    if (bridgeResult == null) {
      developer.log("No bridge found, returning");
      return new HueResults(HueResults.NO_BRIDGE_FOUND, false, "No bridge found");
    }

    HueResults result = await _findUser();
    if (!result.success) {
      developer.log(result.message);
      return result;
    }

    lights = await getLights();
    developer.log("Found lights: " + lights.toString());

    scenes = await getScenes();
    developer.log("Found scenes: " + scenes.toString());

    groups = await getGroups();
    developer.log("Found groups: " + groups.toString());

    setCurrentGroup(groups.first.name);
    return new HueResults(HueResults.CONNECTION_SUCCESSFUL, true, "Successfully connected");
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

  Future<HueResults> _findUser() async {
    String username = await pref.get("username");
    if (username != null) {
      if (username.isNotEmpty) {
        user = new User(username);
        bridgeApi.username = username;
        developer.log(
            "Found username in prefs\nAdding user with username: " + username);
        return new HueResults(HueResults.USER_IN_PREFS, true, "Found username in prefs, adding with username: " + username);
      }
    }

    return _createUser("hueUser");
  }

  Future<HueResults> _createUser(username) async {
    final response = await bridgeApi.createUser(username);
    HueResults result;
    if (response.keys.first == "success") {
      final success = response["success"];
      developer.log("Successfully created user: " + success.toString());

      user = new User(success["username"]);
      bridgeApi.username = user.username;

      await pref.setString("username", user.username);
      result = new HueResults(HueResults.USER_CREATED, true, "User successfully created");
    } else if (response.keys.first == "error") {
      final error = response["error"];
      if (error["type"] == 101) {
        developer.log(
            "Please press the button on your Philips HUE bridge and try again");
        result = new HueResults(HueResults.PRESS_BUTTON, false, "Please press the button on the Philips Hue bridge and try again");
      } else {
        developer.log("Error creating user: " + error.toString());
        result = new HueResults(HueResults.UNKNOWN_USER_ERROR, false, "Error creating user: " + error.toString());
      }
    }
    return result;
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
    if (currentGroup.state.allOn) {
      bridgeApi.changeScene(sceneId, currentGroup.id);
      updateAll();
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
