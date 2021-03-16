import 'dart:async';
import 'package:flutter_ip/flutter_ip.dart';
import 'package:wifi/wifi.dart';

class NetworkService {
  static Future<String> get localIP async {
    try {
      //String localIP = await FlutterIp.internalIP;
      String ip = await Wifi.ip;
      return ip;
    } catch (error) {
      print(error);
    }
    return null;
  }
}
