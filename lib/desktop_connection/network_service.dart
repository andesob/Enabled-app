import 'dart:async';
import 'package:wifi/wifi.dart';
import 'dart:developer' as developer;

/// Returns the local IP address of the device. Does not work on cellular networks.
class NetworkService {
  static Future<String> get localIP async {
    try {
      String ip = await Wifi.ip;
      return ip;
    } catch (error) {
      developer.log(error);
    }
    return null;
  }
}
