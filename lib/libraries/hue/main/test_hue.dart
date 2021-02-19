import 'package:enabled_app/libraries/hue/lights/light.dart';
import 'package:enabled_app/libraries/hue/lights/light_state.dart';
import 'package:enabled_app/libraries/hue/main/bridge.dart';
import 'package:http/http.dart';

void main() {
  LightState state = new LightState(
      true, 3, 4, 5, 6, 7, "_alert", "_effect", "_colormode", false);
  Light light = new Light("_name", "_type", 2, state, "_modelId", "_uniqueId",
      "_manufacturerName", "_productName", "_luminaireUniqueId", "_swVersion");
  //print(light);

  Bridge bridge = Bridge(new Client(), "cat-fact.herokuapp.com");

  print(bridge.get("/facts/1"));
}

class TestMain {}
