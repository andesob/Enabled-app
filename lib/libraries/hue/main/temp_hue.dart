import 'package:enabled_app/libraries/hue/lights/light.dart';
import 'package:enabled_app/libraries/hue/lights/light_state.dart';
import 'package:enabled_app/libraries/hue/main/bridge.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';

void main() {
  runApp(new TempMain());
  /*LightState state = new LightState(
      true, 3, 4, 5, 6, 7, "_alert", "_effect", "_colormode", false);
  Light light = new Light("_name", "_type", 2, state, "_modelId", "_uniqueId",
      "_manufacturerName", "_productName", "_luminaireUniqueId", "_swVersion");
  //print(light);

  Bridge bridge = Bridge(new Client(), "192.168.100.48");

  print(bridge.get("/api"));*/
}

class TempMain extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    Bridge bridge = Bridge(new Client(), "192.168.100.48");

    print(bridge.get("/api"));
    return MaterialApp();
  }
}
