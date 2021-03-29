import 'package:enabled_app/contacts_page/contact_item.dart';
import 'package:enabled_app/global_data/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'custom_category.dart';

class CustomPopup extends StatefulWidget {
  List<CustomCategory> items;

  CustomPopup({Key key, this.items}) : super(key: key);

  @override
  _CustomPopup createState() => _CustomPopup();
}

class _CustomPopup extends State<CustomPopup> {
  final firstNameController = TextEditingController();
  final surnameController = TextEditingController();
  final numberController = TextEditingController();
  FocusNode firstFocusNode;

  List<DropdownMenuItem<CustomCategory>> dropDownItems;
  CustomCategory selectedCategory;

  @override
  void dispose() {
    firstFocusNode.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    firstFocusNode = new FocusNode();
    firstFocusNode.addListener(_onOnFocusNodeEvent);

    dropDownItems = buildDropDownMenuItems(widget.items);
    //selectedCategory = dropDownItems[0].value;
  }

  List<DropdownMenuItem<CustomCategory>> buildDropDownMenuItems(
      List categories) {
    List<DropdownMenuItem<CustomCategory>> items = [];
    for (CustomCategory item in categories) {
      items.add(
        DropdownMenuItem(
          child: Center(
            child: Text(
              item.categoryName,
              style: TextStyle(
                decoration: TextDecoration.underline,
                fontSize: 16,
                //fontStyle: FontStyle.italic,
              ),
            ),
          ),
          value: item,
        ),
      );
    }
    return items;
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
      title: Text('Legg til en ny snarvei'),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          child: Column(
            children: <Widget>[
              InputDecorator(
                isFocused: true,
                decoration: InputDecoration(
                  labelStyle: Theme.of(context)
                      .primaryTextTheme
                      .caption
                      .copyWith(color: Colors.black),
                  border: OutlineInputBorder(),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    focusColor: Color(StaticColors.darkPeach),
                    isDense: true,
                    hint: selectedCategory == null
                        ? Text('Kategori',
                            style: TextStyle(
                                color: Color(StaticColors.lightSlateGray)))
                        : Text(
                            selectedCategory.categoryName,
                            style: TextStyle(
                              color: Color(StaticColors.lightSlateGray),
                            ),
                          ),
                    isExpanded: true,
                    iconSize: 25.0,
                    style: TextStyle(
                      color: Color(
                        StaticColors.darkPeach,
                      ),
                    ),
                    items: dropDownItems,
                    onChanged: (item) {
                      setState(
                        () {
                          selectedCategory = item;
                        },
                      );
                    },
                  ),
                ),
              ),
              TextFormField(
                focusNode: firstFocusNode,
                controller: firstNameController,
                decoration: InputDecoration(
                  labelStyle:
                      new TextStyle(color: _getLabelColor(firstFocusNode)),
                  labelText: 'Tekst',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: _getLabelColor(firstFocusNode),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      child: Text("Lukk"),
                      color: Color(StaticColors.lightSlateGray),
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        Navigator.pop(context);
                      },
                    ),
                    RaisedButton(
                      child: Text("Legg til"),
                      color: Color(StaticColors.lightSlateGray),
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        Navigator.pop(context, firstNameController.text);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
