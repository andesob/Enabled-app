import 'package:enabled_app/contacts_page/contact_item_data.dart';
import 'package:enabled_app/global_data/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class ContactItem extends StatefulWidget {
  final bool isFocused;
  final ContactItemData cData;
  final ValueSetter<String> onDelete;

  ContactItem({
    Key key,
    this.isFocused = false,
    this.onDelete,
    this.cData,
  }) : super(key: key);

  @override
  _ContactItem createState() => _ContactItem();
}

class _ContactItem extends State<ContactItem> {
  @override
  Widget build(BuildContext context) {
    String firstname = widget.cData.getFirstname;
    String surname = widget.cData.getLastname;
    String number = widget.cData.getNumber;

    return Row(
        /* height:
          ((MediaQuery.of(context).size.height - kBottomNavigationBarHeight) *
              0.14),*/
        children: [
          Expanded(
            child: ListTile(
              onTap: () => _launchURL(number),
              leading: CircleAvatar(
                backgroundColor: widget.isFocused
                    ? Color(StaticColors.charcoal)
                    : Color(StaticColors.lighterSlateGray),
                child: Text(
                  firstname[0],
                  style: TextStyle(color: Color(StaticColors.white)),
                ),
              ),
              title: Text(
                firstname + " " + surname,
                style: widget.isFocused
                    ? TextStyle(fontWeight: FontWeight.bold)
                    : TextStyle(fontWeight: FontWeight.normal),
              ),
              subtitle: Text(
                number,
                style: widget.isFocused
                    ? TextStyle(fontWeight: FontWeight.bold)
                    : TextStyle(fontWeight: FontWeight.normal),
              ),
            ),
          ),
          FlatButton(
            child: Icon(Icons.delete_forever),
            onPressed: () {
              widget.onDelete?.call(widget.cData.contactId);
            },
          ),
        ]);
  }

  _launchURL(number) async {
    bool res = await FlutterPhoneDirectCaller.callNumber(number);
  }
}
