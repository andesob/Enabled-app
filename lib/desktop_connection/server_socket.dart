import 'dart:async';
import 'dart:io';
import 'package:enabled_app/desktop_connection/network_service.dart';
import 'dart:developer' as developer;

/// The SocketSingleton class is a simple WebSocket server listening for
/// messages from WebSocket clients and updating the stream when a new message
/// is received.
class SocketSingleton {
  /// The singleton instance for the socket server.
  static final SocketSingleton _singleton = SocketSingleton._internal();

  /// The local ip string. Is set when _startSocket is called.
  String _localIP;

  /// The server socket waiting for socket clients to connect.
  HttpServer _serverSocket;

  /// The socket client connecting.
  WebSocket _clientSocket;

  /// The port the server socket is listening to.
  int _port = 9000;

  /// The streamcontroller for the Stream object.
  StreamController<String> controller = StreamController<String>.broadcast();

  /// The Stream object other classes can subscribe to. Notifies all subscribers when the data changes.
  Stream stream;

  /// Creates the Singleton instance.
  factory SocketSingleton() {
    return _singleton;
  }

  /// Call the _startSocket method when a new instance is created.
  SocketSingleton._internal() {
    _startSocket();
  }

  /// Initializes the WebSocket server and listens on the selected port.
  _startSocket() async {
    developer.log("start socket called");
    _localIP = await _getIP();
    developer.log("Get ip: " + _localIP);
    _serverSocket = await HttpServer.bind(_localIP, _port, shared: true);
    _serverSocket.transform(WebSocketTransformer()).listen(_handleClient);
    developer.log("server ip: " + _serverSocket.address.toString());
    developer.log("server port: " + _serverSocket.port.toString());
  }

  /// Fetches and returns the local IP address from the network services class.
  Future<String> _getIP() async {
    String ip = await NetworkService.localIP;
    return ip;
  }

  /// Handles the WebSocket client connecting to the server. When the client sends something, the stream gets updated.
  void _handleClient(WebSocket client) {
    _clientSocket = client;
    stream = controller.stream;

    _clientSocket.listen(
      (data) {
        controller.add(data);
      },
      onError: (e) {
        _disconnectClient();
      },
      onDone: () {
        developer.log("Connection has terminated.");
        _disconnectClient();
      },
    );
  }

  ///Disconnects the client connected to the server.
  void _disconnectClient() {
    if (_clientSocket != null) {
      _clientSocket.close();
    }
    _clientSocket = null;
  }

  /// Returns the stream. The object notifies the listeners when it is updated.
  Stream getStream() {
    return controller.stream;
  }

  /// Returns the local IP address of the device.
  String getLocalIP() {
    return _localIP;
  }
}
