import 'dart:async';
import 'dart:io';
import 'package:enabled_app/desktop_connection/network_service.dart';

class SocketSingleton {
  static final SocketSingleton _singleton = SocketSingleton._internal();
  String _localIP;
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
    _localIP = await _getIP();
    print("Get ip: " + _localIP);
    _serverSocket = await HttpServer.bind(_localIP, _port, shared: true);
    _serverSocket.transform(WebSocketTransformer()).listen(_handleClient);
    print("server ip: " + _serverSocket.address.toString());
    print("server port: " + _serverSocket.port.toString());
  }

  String get command {
    return this.command;
  }

  Future<String> _getIP() async {
    String ip = await NetworkService.localIP;
    return ip;
  }

  void _handleClient(WebSocket client) {
    _clientSocket = client;
    stream = controller.stream;

    _clientSocket.listen(
      (data) {
        //print(data);
        controller.add(data);
      },
      onError: (e) {
        _disconnectClient();
      },
      onDone: () {
        print("Connection has terminated.");
        _disconnectClient();
      },
    );
  }

  void _disconnectClient() {
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
