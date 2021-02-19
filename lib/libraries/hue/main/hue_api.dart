import 'package:enabled_app/libraries/hue/lights/light_api.dart';
import 'package:enabled_app/libraries/hue/main/bridge.dart';
import 'package:http/http.dart';

class HueApi{
  final LightApi _lightApi;

  String _username;

  //TODO: Add all the other api's to constructor
  HueApi(Client client, String address)
  : this._init(LightApi(Bridge(client, address)));

  HueApi._init(this._lightApi);

  //TODO: Add setter for username




}