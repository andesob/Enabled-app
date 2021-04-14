import 'package:enabled_app/contacts_page/contact_item.dart';
import 'package:enabled_app/global_data/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'custom_category.dart';

class CustomPopup extends StatefulWidget {
  final List<CustomCategory> items;

  CustomPopup({Key key, this.items}) : super(key: key);

  @override
  _CustomPopup createState() => _CustomPopup();
}

class _CustomPopup extends State<CustomPopup> {
  final textInputController = TextEditingController();
  final categoryInputController = TextEditingController();
  FocusNode firstFocusNode;
  FocusNode secondFocusNode;
  CustomCategory selectedCategory;
  bool addingCategory = false;
  bool validateCategory = true;
  bool validateCategoryTextfield = true;
  bool validateTextfield = true;

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
    secondFocusNode = new FocusNode();
    secondFocusNode.addListener(_onOnFocusNodeEvent);
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
      title: Text('Add a new shortcut'),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          child: Column(
            children: <Widget>[
              addingCategory ? getAddCategory() : getDropdown(),
              if (!addingCategory) getAddCategoryButton(),
              TextFormField(
                focusNode: firstFocusNode,
                controller: textInputController,
                decoration: InputDecoration(
                  errorText: validateTextfield ? null : "Enter a name for the shortcut",
                  labelStyle:
                      new TextStyle(color: _getLabelColor(firstFocusNode)),
                  labelText: 'New shortcut',
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
                      child: Text("Close"),
                      color: Color(StaticColors.lightSlateGray),
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        Navigator.pop(context);
                      },
                    ),
                    RaisedButton(
                      child: Text("Add"),
                      color: Color(StaticColors.lightSlateGray),
                      onPressed: () {
                        setState(() {
                          int errors = 0;
                          if (selectedCategory == null && !addingCategory) {
                            validateCategory = false;
                            errors++;
                          }

                          if(categoryInputController.text.isEmpty && addingCategory){
                            validateCategoryTextfield = false;
                            errors++;
                          }

                          if (textInputController.text.isEmpty) {
                            validateTextfield = false;
                            errors++;
                          }

                          if(errors > 0){
                            return;
                          }

                          if (addingCategory) {
                            CustomCategory category = new CustomCategory(
                                categoryInputController.text, []);
                            widget.items.add(category);
                            category.objects.add(textInputController.text);
                            FocusScope.of(context).unfocus();
                            Navigator.pop(context, category.name);
                          } else {
                            selectedCategory.objects
                                .add(textInputController.text);
                            FocusScope.of(context).unfocus();
                            Navigator.pop(context, textInputController.text);
                          }
                        });
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

  Container getAddCategoryButton() {
    return Container(
      child: RaisedButton(
        child: Text("Add category"),
        color: Color(StaticColors.lightSlateGray),
        onPressed: () {
          setState(() {
            addingCategory = true;
          });
        },
      ),
    );
  }

  TextFormField getAddCategory() {
    return TextFormField(
      focusNode: secondFocusNode,
      controller: categoryInputController,
      decoration: InputDecoration(
        errorText: validateCategoryTextfield ? null : "Enter a name for the category",
        labelStyle: new TextStyle(color: _getLabelColor(secondFocusNode)),
        labelText: 'New category',
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: _getLabelColor(secondFocusNode),
          ),
        ),
      ),
    );
  }

  InputDecorator getDropdown() {
    return InputDecorator(
      isFocused: true,
      decoration: InputDecoration(
        errorText: validateCategory ? null : "Select a category",
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
              ? Text(
                  'Category',
                  style: TextStyle(
                    color: Color(StaticColors.lightSlateGray),
                  ),
                )
              : Text(
                  selectedCategory.name,
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
          items: widget.items.map((item) {
            return new DropdownMenuItem(
              child: Center(
                child: Text(
                  item.name,
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 16,
                    //fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              value: item,
            );
          }).toList(),
          onChanged: (item) {
            setState(
              () {
                selectedCategory = item;
              },
            );
          },
        ),
      ),
    );
  }
}
