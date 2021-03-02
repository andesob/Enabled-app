import 'dart:async';
import 'dart:io';

import 'package:enabled_app/observer/observer.dart';
import 'package:get_ip/get_ip.dart';

class SocketSingleton implements StateListener {
  static final SocketSingleton _singleton = SocketSingleton._internal();
  String _localIP = "localhost";
  HttpServer _serverSocket;
  WebSocket _clientSocket;
  int _port = 9000;
  String lastCommand = "";

  factory SocketSingleton() {
    return _singleton;
  }

  SocketSingleton._internal() {
    startSocket();
  }

  startSocket() async {
    print("start socket called");
    if (_serverSocket != null) {
      _localIP = await getIP();
      _serverSocket = await HttpServer.bind(_localIP, _port, shared: true);
      _serverSocket.transform(WebSocketTransformer()).listen(handleClient);
    }
  }

  String get command {
    return this.command;
  }

  Future<String> getIP() async {
    String ip = await GetIp.ipAddress;
    return ip;
  }

  void handleClient(WebSocket client) {
    _clientSocket = client;

    _clientSocket.listen(
      (data) {
        print(data);
        StateProvider stateProvider = StateProvider();
        stateProvider.notify(ObserverState.COMMAND_RECEIVED);
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

  @override
  void onStateChanged(ObserverState state) {
    // TODO: implement onStateChanged
  }
}
