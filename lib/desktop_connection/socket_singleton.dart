import 'dart:io';

import 'package:enabled_app/observer/observer.dart';
import 'package:flutter/material.dart';
import 'package:get_ip/get_ip.dart';

SocketServerState pageState;

class SocketServer extends StatefulWidget {
  @override
  SocketServerState createState() {
    pageState = SocketServerState();
    return pageState;
  }
}

class SocketServerState extends State<SocketServer> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<String> items = [];
  String message = "No message";

  String localIP = "";

  HttpServer serverSocket;
  WebSocket clientSocket;
  int port = 9000;

  @override
  void dispose() {
    stopServer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    getIP();
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(title: Text("Socket Server")),
      body: Column(
        children: <Widget>[
          ipInfoArea(),
          messageListArea(),
        ],
      ),
    );
  }

  Widget ipInfoArea() {
    return Card(
      child: ListTile(
        dense: true,
        leading: Text("IP"),
        title: Text(localIP),
        trailing: RaisedButton(
          child: Text((serverSocket == null) ? "Start" : "Stop"),
          onPressed: (serverSocket == null) ? startServer : stopServer,
        ),
      ),
    );
  }

  Widget messageListArea() {
    return Center(
      child: Text(
        message,
        style: TextStyle(fontSize: 18),
      ),
    );
  }

  void getIP() async {
    var ip = await GetIp.ipAddress;
    setState(() {
      localIP = ip;
    });
  }

  void startServer() async {
    serverSocket = await HttpServer.bind(localIP, 9000, shared: true);
    serverSocket.transform(WebSocketTransformer()).listen(handleClient);
  }

  void handleClient(WebSocket client) {
    clientSocket = client;

    clientSocket.listen(
      (data) {
        setState(() {
          message = data;
        });
      },
      onError: (e) {
        showSnackBarWithKey(e.toString());
        disconnectClient();
      },
      onDone: () {
        showSnackBarWithKey("Connection has terminated.");
        disconnectClient();
      },
    );
  }

  void stopServer() {
    disconnectClient();
    serverSocket.close();
    setState(() {
      serverSocket = null;
    });
  }

  void disconnectClient() {
    if (clientSocket != null) {
      clientSocket.close();
      clientSocket.close();
    }

    setState(() {
      clientSocket = null;
    });
  }

  showSnackBarWithKey(String message) {
    scaffoldKey.currentState
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text(message),
        action: SnackBarAction(
          label: 'Done',
          onPressed: () {},
        ),
      ));
  }
}
