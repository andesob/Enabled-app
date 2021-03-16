import 'dart:async';
import 'dart:io';
import 'package:enabled_app/desktop_connection/network_service.dart';

class SocketSingleton {
  static final SocketSingleton _singleton = SocketSingleton._internal();
  String _localIP;
  String _externalIP;
  HttpServer _serverSocket;
  WebSocket _clientSocket;
  int _port = 9000;
  String lastCommand = "";

  StreamController<String> controller = StreamController<String>.broadcast();
  Stream stream;

  factory SocketSingleton() {
    return _singleton;
  }

  SocketSingleton._internal() {
    _startSocket();
  }

  _startSocket() async {
    print("start socket called");
    _localIP = await getIP();
    print("Get ip: " + _localIP);
    print("Get external ip: " + _localIP);
    _serverSocket = await HttpServer.bind(_localIP, _port, shared: true);
    _serverSocket.transform(WebSocketTransformer()).listen(handleClient);
    print("server ip: " + _serverSocket.address.toString());
    print("server port: " + _serverSocket.port.toString());
  }

  String get command {
    return this.command;
  }

  Future<String> getIP() async {
    String ip = await NetworkService.localIP;
    return ip;
  }

  Future<String> getExternalIP() async {
    String ip = await NetworkService.localIP;
    return ip;
  }

  void handleClient(WebSocket client) {
    _clientSocket = client;
    stream = controller.stream;

    _clientSocket.listen(
      (data) {
        print(data);
        controller.add(data);
      },
      onError: (e) {
        disconnectClient();
      },
      onDone: () {
        print("Connection has terminated.");
        disconnectClient();
      },
    );
  }

  void disconnectClient() {
    if (_clientSocket != null) {
      _clientSocket.close();
      _clientSocket.close();
    }
    _clientSocket = null;
  }

  Stream getStream() {
    return controller.stream;
  }
}