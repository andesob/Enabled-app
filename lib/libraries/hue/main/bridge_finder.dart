import 'dart:convert';

import 'package:enabled_app/libraries/hue/main/bridge_finder_result.dart';
import 'package:http/http.dart';

class BridgeFinder{
  Client _client;

  BridgeFinder(this._client);

  Future<List<BridgeFinderResult>> automatic() async {
    final url = "https://discovery.meethue.com/";
    final response = await _client.get(url);
    List jsonResponse = json.decode(response.body);
    final result = <BridgeFinderResult> [];
    for (Map<String, dynamic> json in jsonResponse){
      result.add(BridgeFinderResult.fromJson(json));
    }

    return result;
  }

  Future<BridgeFinderResult> manual(String ipAddress) async {
    final url = "http://$ipAddress/api/hue/config";
    final response = await _client.get(url);
    Map jsonResponse = json.decode(response.body);
    final result = BridgeFinderResult.fromJson(jsonResponse);
    return result;
  }
}