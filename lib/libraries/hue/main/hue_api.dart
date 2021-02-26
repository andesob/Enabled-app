import 'package:enabled_app/libraries/hue/lights/light.dart';
import 'package:enabled_app/libraries/hue/lights/light_api.dart';
import 'package:enabled_app/libraries/hue/lights/light_state.dart';
import 'package:enabled_app/libraries/hue/main/bridge.dart';
import 'package:http/http.dart';

class HueApi{
  final LightApi _lightApi;
  List<Light> list;

  String _username = "oDvEKoVrvzzHpKgOuXSZGvueCn2fSE-snTpYayfg";

  //TODO: Add all the other api's to constructor
  HueApi(Client client, String address)
  : this._init(LightApi(Bridge(client, address), "oDvEKoVrvzzHpKgOuXSZGvueCn2fSE-snTpYayfg"));

  HueApi._init(this._lightApi);

  set username(String username) {
    this._username = username;
  }

Future<List<Light>> getLights() async {
    return await _lightApi.getAll();
}

Future<void> lights() async {
  list = await getLights();
  //print(list[0].state.on);
  print(list[0].state);
}

void update(){
    LightState state = list[0].state;
    state.on = true;
    updateLightState(1, state);
}

void updateLightState(int id, LightState state) async {
    _lightApi.updateState(id, state);
}

  //TODO: Add setter for username




}