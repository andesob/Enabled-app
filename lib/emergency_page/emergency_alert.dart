import 'package:enabled_app/emergency_page/emergency_popup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmergencyAlert extends StatefulWidget{

  EmergencyAlert({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EmergencyAlertState();
}

class _EmergencyAlertState extends State<EmergencyAlert>{
  @override
  Widget build(BuildContext context) {
    /// The alert to trigger if no Emergency Contact was set
    return AlertDialog(
      title: Text('No Emergency Contact Set'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text('Please set an emergency contact now'),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Set Contact'),
          onPressed: () {
            Navigator.of(context).pop();
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return EmergencyPopup();
                });
          },
        ),
        TextButton(
          child: Text('Later'),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

}