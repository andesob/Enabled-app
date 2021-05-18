import 'package:enabled_app/global_data/colors.dart';
import 'package:enabled_app/emergency_page/emergency_contact.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Widget to represent the emergency popup'
///
/// Triggered when user wants to add a new [EmergencyContact]
class EmergencyPopup extends StatefulWidget {

  EmergencyPopup({Key key}) : super(key: key);

  @override
  _EmergencyPopupState createState() => _EmergencyPopupState();
}

class _EmergencyPopupState extends State<EmergencyPopup> {
  SharedPreferences prefs;

  /// Controller for the inputfield.
  ///
  /// User inputs the number of emergency contact
  final emergencyNumberController = TextEditingController();

  /// Focusnode for the TextFormField.
  FocusNode emergencyFocusNode;

  @override
  void dispose() {
    emergencyFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initPrefs();
    emergencyFocusNode = new FocusNode();

    emergencyFocusNode.addListener(_onOnFocusNodeEvent);
  }

  Future<void> _initPrefs() async {
    prefs = await SharedPreferences.getInstance();
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
              EmergencyContact.emergencyContact = emergencyNumberController.text;
              prefs.setString("emergency", EmergencyContact.emergencyContact);
              emergencyNumberController.clear();
              Navigator.pop(context);
            })
      ],
    );
  }
}
