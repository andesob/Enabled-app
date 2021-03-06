import 'dart:async';
import 'dart:convert';

import 'package:enabled_app/desktop_connection/server_socket.dart';
import 'package:enabled_app/global_data/colors.dart';
import 'package:enabled_app/page_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;

/// The ButtonController class controls the navigation inputs received from the user.
class ButtonController extends StatefulWidget {
  final GlobalKey<PageState> pageKey;

  ButtonController({Key key, this.pageKey}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ButtonControllerState();
}

class ButtonControllerState extends State<ButtonController> {
  StreamSubscription sub;

  /// Starts the stream when the widget is loaded.
  @override
  void initState() {
    super.initState();
    startStream();
  }

  /// Unsubscribes to the stream when the widget is disposed.
  @override
  void dispose() {
    super.dispose();
    sub.cancel();
  }

  /// Starts listening to the stream. Depending on the stream object value it
  /// either  sends a mental command or facial command.
  startStream() {
    SocketSingleton socket = SocketSingleton();
    Stream stream = socket.getStream();
    sub = stream.listen((value) {
      setState(() {
        Map stream = jsonDecode(value);
        if (stream['streamType'] == 'com') {
          mentalCommands(stream['command']);
        } else if (stream['streamType'] == 'fac') {
          facialCommands(stream['command']);
        }
      });
    });
  }

  /// Checks for a corresponding Mental Command message. If found, it will call on the
  /// correct method and navigate in the application.
  void mentalCommands(state) {
    switch (state) {
      case 'push':
        {
          widget.pageKey.currentState?.pushPressed();
        }
        break;
      case 'pull':
        {
          widget.pageKey.currentState?.pullPressed();
        }
        break;
      case 'left':
        {
          widget.pageKey.currentState?.leftPressed();
        }
        break;
      case 'right':
        {
          widget.pageKey.currentState?.rightPressed();
        }
        break;
      default:
        {
          developer.log('Unknown mental command');
        }
        break;
    }
  }

  /// Checks for a corresponding Facial Command message. If found, it will call on the
  /// correct method and navigate in the application.
  void facialCommands(state) {
    switch (state) {
      case 'smile':
        {
          widget.pageKey.currentState?.pushPressed();
        }
        break;
      case 'raise-brows':
        {
          widget.pageKey.currentState?.pullPressed();
        }
        break;
      case 'winkL':
        {
          widget.pageKey.currentState?.leftPressed();
        }
        break;
      case 'winkR':
        {
          widget.pageKey.currentState?.rightPressed();
        }
        break;
      default:
        {}
        break;
    }
  }

  /// Navigates the page when a button is pressed.
  buttonIsPressed(int index) {
    if (index == 0) {
      widget.pageKey.currentState?.pushPressed();
    }
    if (index == 1) {
      widget.pageKey.currentState?.pullPressed();
    }
    if (index == 2) {
      widget.pageKey.currentState?.leftPressed();
    }
    if (index == 3) {
      widget.pageKey.currentState?.rightPressed();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: buttonIsPressed,
      unselectedItemColor: Color(StaticColors.lighterSlateGray),
      selectedItemColor: Color(StaticColors.lighterSlateGray),
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.arrow_upward),
          label: 'Push',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.arrow_downward),
          label: 'Pull',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: 'Left',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.backup),
          label: 'Right',
        ),
      ],
    );
  }
}
