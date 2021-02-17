import 'dart:convert';
import 'dart:io';

import 'package:enabled_app/smart/hue/user.dart';
import 'package:http/http.dart';
import 'package:hue_dart/hue_dart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HueApi {
  static final HueApi _api = HueApi._internal();
  final client = Client();

  BridgeDiscovery discovery;
  DiscoveryResult discoveryResult;
  Bridge bridge;
  User user;
  List<Light> lights;
  List<Scene> scenes;
  List<Group> groups;
  List<Rule> rules;
  SharedPreferences pref;

  factory HueApi() {
    return _api;
  }

  HueApi._internal();

  Future<void> findBridge() async {
    discovery = BridgeDiscovery(client);

    List<DiscoveryResult> discoverResults = await discovery.automatic();
    discoveryResult = discoverResults.first;

    bridge = Bridge(client, discoveryResult.ipAddress);
    print("IP: " + discoveryResult.ipAddress);

    lights = await getLights();
    scenes = await getScenes();
    groups = await getGroups();
    rules = await getRules();

    pref = await SharedPreferences.getInstance();
    String username = await pref.get("username");
    if (username != null) {
      if (username.isNotEmpty) {
        user = new User(username);
        bridge.username = user.username;
      }
    }

    if (user != null) {
      print("LOGGED IN USER: " + user.username);
    }
  }

  Future<void> createUser(username) async {
    if (bridge != null) {
      final whiteListItem = await bridge.createUser(username);
      user = new User(whiteListItem.username);
      bridge.username = user.username;

      await pref.setString("username", whiteListItem.username);

      print("USER CREATED: " + whiteListItem.username);
    }
  }

  Future<void> changeColors(double red, double green, double blue) async {
    if (lights != null) {
      for (Light light in lights) {
        final newLight = light.changeColor(red: red, green: green, blue: blue);
        LightState state = lightStateForColorOnly(newLight);
        await bridge.updateLightState(newLight.rebuild(
          (l) => l..state = state.toBuilder(),
        ));
      }
    }
  }

  Future<List<Rule>> getRules() async{
    List<Rule> list;
    if(bridge != null && user != null){
      list = await bridge.rules();
    }

    return list;
  }

  Future<List<Light>> getLights() async {
    List<Light> list;
    if (bridge != null && user != null) {
      list = await bridge.lights();
    }

    return list;
  }

  Future<List<Scene>> getScenes() async {
    List<Scene> list;
    if (bridge != null && user != null) {
      list = await bridge.scenes();
    }

    return list;
  }

  Future<List<Group>> getGroups() async {
    List<Group> list;
    if (bridge != null && user != null) {
      list = await bridge.groups();
    }

    return list;
  }

  Future<void> changeScene(String sceneId, String groupId) async {
    if (bridge != null) {
      String url = "http://" +
          discoveryResult.ipAddress +
          "/api/" +
          user.username +
          "/groups/" +
          groupId +
          "/action";
      var body = json.encode({"scene": sceneId});

      final response = await put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body,
      );
      print(body);
      print(response.body);
    }
  }

  Future<void> powerOnAll() async {
    if (bridge != null) {
      if (lights == null) {
        lights = await bridge.lights();
      }

      for (Light l in lights) {
        LightState state = LightState(
          (s) => s..on = true,
        );

        await bridge.updateLightState(l.rebuild(
          (l) => l..state = state.toBuilder(),
        ));
      }
    }
  }

  Future<void> powerOffAll() async {
    if (bridge != null) {
      if (lights == null) {
        lights = await bridge.lights();
      }

      for (Light l in lights) {
        LightState state = LightState(
          (s) => s..on = false,
        );

        await bridge.updateLightState(l.rebuild(
          (l) => l..state = state.toBuilder(),
        ));
      }
    }
  }
}
