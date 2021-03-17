import 'package:enabled_app/colors/colors.dart';
import 'package:enabled_app/emergency_page/emergency_contact.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmergencyPopup extends StatefulWidget {

  EmergencyPopup({Key key}) : super(key: key);

  @override
  _EmergencyPopupState createState() => _EmergencyPopupState();
}

class _EmergencyPopupState extends State<EmergencyPopup> {
  final emergencyNumberController = TextEditingController();

  FocusNode emergencyFocusNode;

  @override
  void dispose() {
    emergencyFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    emergencyFocusNode = new FocusNode();

    emergencyFocusNode.addListener(_onOnFocusNodeEvent);
  }

  _onOnFocusNodeEvent() {
    setState(() {});
  }

  Color _getLabelColor(FocusNode node) {
    return node.hasFocus
        ? Color(StaticColors.apricot)
        : Color(StaticColors.lighterSlateGray);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Text('Add Emergency Contact'),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          child: Column(
            children: <Widget>[
              TextFormField(
                focusNode: emergencyFocusNode,
                controller: emergencyNumberController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelStyle:
                  new TextStyle(color: _getLabelColor(emergencyFocusNode)),
                  labelText: 'Number',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: _getLabelColor(emergencyFocusNode),
                    ),
                  ),
                  icon: Icon(
                    Icons.contacts,
                    color: _getLabelColor(emergencyFocusNode),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        RaisedButton(
            child: Text("Submit"),
            color: Color(StaticColors.lightSlateGray),
            onPressed: () {
              StaticEmergencyContact.emergencyContact = emergencyNumberController.text;
              emergencyNumberController.clear();
              Navigator.pop(context);
            })
      ],
    );
  }
}
