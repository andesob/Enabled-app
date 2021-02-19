import 'dart:convert';

import 'package:http/http.dart';

class Bridge {
  final String IP_PREFIX = "https://";

  Client _client;
  String _address;

  Bridge(Client client, String address) {
    this._client = client;
    this._address = IP_PREFIX + address;
  }

  Future<Map<String, dynamic>> get(String url) async {
    final response = await _client.get(_address + url);
    print(response.body);
    Map responseMap = json.decode(response.body);
    return responseMap;
  }

  Future<Map<String, dynamic>> post(String url, [dynamic body]) async {
    var response;
    if (body == null) {
      response = await _client.post(_address + url);
    } else {
      response = await _client.post(_address + url, body: json.encode(body));
    }

    var responseMap = json.decode(response.body);
    return responseMap;
  }

  Future<Map<String, dynamic>> put(String url, [dynamic body]) async {
    var response;
    if (body == null) {
      response = await _client.put(_address + url);
    } else {
      response = await _client.put(_address + url, body: json.encode(body));
    }

    var responseMap = json.decode(response.body);
    return responseMap;
  }

}