import 'dart:convert';

import 'package:enabled_app/global_data/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'contact_item.dart';
import 'contact_item_data.dart';

class ContactPopup extends StatefulWidget {
  final List<ContactItemData> items;

  ContactPopup({
    Key key,
    this.items,
  }) : super(key: key);

  @override
  _ContactPopupState createState() => _ContactPopupState();
}

class _ContactPopupState extends State<ContactPopup> {
  SharedPreferences prefs;

  final firstNameController = TextEditingController();
  final surnameController = TextEditingController();
  final numberController = TextEditingController();

  FocusNode firstFocusNode;
  FocusNode lastFocusNode;
  FocusNode numberFocusNode;

  @override
  void dispose() {
    firstFocusNode.dispose();
    lastFocusNode.dispose();
    numberFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    initPrefs();

    firstFocusNode = new FocusNode();
    lastFocusNode = new FocusNode();
    numberFocusNode = new FocusNode();

    firstFocusNode.addListener(_onOnFocusNodeEvent);
    lastFocusNode.addListener(_onOnFocusNodeEvent);
    numberFocusNode.addListener(_onOnFocusNodeEvent);
  }

  initPrefs() async {
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
      title: Text('Add New Contact'),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          child: Column(
            children: <Widget>[
              TextFormField(
                focusNode: firstFocusNode,
                controller: firstNameController,
                decoration: InputDecoration(
                  labelStyle:
                      new TextStyle(color: _getLabelColor(firstFocusNode)),
                  labelText: 'First Name',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: _getLabelColor(firstFocusNode),
                    ),
                  ),
                  icon: Icon(
                    Icons.account_box,
                    color: _getLabelColor(firstFocusNode),
                  ),
                ),
              ),
              TextFormField(
                focusNode: lastFocusNode,
                controller: surnameController,
                decoration: InputDecoration(
                  labelStyle:
                      new TextStyle(color: _getLabelColor(lastFocusNode)),
                  labelText: 'Surname',
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: _getLabelColor(lastFocusNode),
                    ),
                  ),
                  icon: Icon(
                    Icons.edit_sharp,
                    color: _getLabelColor(lastFocusNode),
                  ),
                ),
              ),
              TextFormField(
                focusNode: numberFocusNode,
                controller: numberController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelStyle:
                      new TextStyle(color: _getLabelColor(numberFocusNode)),
                  labelText: 'Number',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: _getLabelColor(numberFocusNode),
                    ),
                  ),
                  icon: Icon(
                    Icons.add_ic_call,
                    color: _getLabelColor(numberFocusNode),
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
              if (!validateInput()) {
                return;
              }

              ContactItemData cItem = ContactItemData(
                firstName: firstNameController.text,
                lastName: surnameController.text,
                number: numberController.text,
              );
              widget.items.add(cItem);

              updatePrefs();

              firstNameController.clear();
              surnameController.clear();
              numberController.clear();
              Navigator.pop(context);
            })
      ],
    );
  }

  void updatePrefs() {
    List<String> prefList = [];
    for (ContactItemData cData in widget.items) {
      prefList.add(jsonEncode(cData.toJson()));
    }

    prefs.setStringList("contacts", prefList);
  }

  bool validateInput() {
    int errors = 0;

    if (firstNameController.text == null || firstNameController.text.isEmpty) {
      errors++;
    }

    if (surnameController.text == null || surnameController.text.isEmpty) {
      errors++;
    }

    if (numberController.text == null || numberController.text.isEmpty) {
      errors++;
    }

    return errors == 0;
  }
}
