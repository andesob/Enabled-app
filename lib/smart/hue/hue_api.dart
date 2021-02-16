import 'package:enabled_app/smart/hue/user.dart';
import 'package:http/http.dart';
import 'package:hue_dart/hue_dart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HueApi {
  static const String BRIDGE_IP = "192.168.100.33";

  static final HueApi _api = HueApi._internal();
  final client = Client();

  BridgeDiscovery discovery;
  DiscoveryResult discoveryResult;
  Bridge bridge;
  User user;
  List<Light> lights;
  List<Scene> scenes;
  List<Group> groups;
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


    pref = await SharedPreferences.getInstance();
    String username = await pref.get("username");
    if (username != null) {
      if (username.isNotEmpty) {
        user = new User(username);
        bridge.username = user.username;
      }
    }

    if (user != null) {
      print("USERNAME: " + user.username);
    }
  }

  Future<void> createUser(username) async {
    if (bridge != null) {
      final whiteListItem = await bridge.createUser(username);
      user = new User(whiteListItem.username);
      bridge.username = user.username;

      await pref.setString("username", whiteListItem.username);

      print("USERNAME: " + whiteListItem.username);
    }
  }

  Future<void> getLights() async {
    if (bridge != null && user != null && lights == null) {
      lights = await bridge.lights();
    }
    for (Light light in lights) {
      print("LIGHTS: " + light.name);
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

  Future<void> getScenes() async {
    if(bridge != null){
      scenes = await bridge.scenes();
      for(Scene scene in scenes){
        print("SCENE: " + scene.toString());
      }
    }
  }

  Future<void> getGroups() async {
    if(bridge != null){
      groups = await bridge.groups();
      for(Group group in groups){
        print("GROUP: " + group.toString());
      }
    }
  }
}
