import 'package:enabled_app/desktop_connection/network_service.dart';
import 'package:enabled_app/desktop_connection/server_socket.dart';
import 'package:enabled_app/global_data/colors.dart';
import 'package:enabled_app/emergency_page/emergency_contact.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IpPopup extends StatefulWidget {
  IpPopup({Key key}) : super(key: key);

  @override
  _IpPopupState createState() => _IpPopupState();
}

class _IpPopupState extends State<IpPopup> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Mobile IP address'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text('IP address to add in the Desktop App:'),
            Text("\n"),
            Text(SocketSingleton().getLocalIP(), style: TextStyle(fontWeight: FontWeight.bold),),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Approve'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
