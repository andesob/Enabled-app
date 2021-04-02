import 'dart:async';
import 'package:wifi/wifi.dart';

class NetworkService {
  static Future<String> get localIP async {
    try {
      String ip = await Wifi.ip;
      return ip;
    } catch (error) {
      print(error);
    }
    return null;
  }
}
