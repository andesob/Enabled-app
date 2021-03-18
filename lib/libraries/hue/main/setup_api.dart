import 'package:enabled_app/libraries/hue/main/bridge.dart';

class SetupApi {
  Bridge _bridge;

  SetupApi(this._bridge);

  Bridge get bridge => _bridge;

  Future<Map<String, dynamic>> createUser(String name) async {
    final String url = "/api";
    final response = await _bridge.post(url, {'devicetype': name});
    final Map<String, dynamic> responseMap = response[0];
    return responseMap;
  }
}