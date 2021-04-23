import 'package:enabled_app/global_data/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class ContactItem extends StatefulWidget {
  final String firstname;
  final String lastname;
  final String number;
  final bool isFocused;

  ContactItem({
    Key key,
    this.firstname,
    this.lastname,
    this.number,
    this.isFocused = false,
  }) : super(key: key);

  @override
  _ContactItem createState() => _ContactItem();
}

class _ContactItem extends State<ContactItem> {

  @override
  Widget build(BuildContext context) {
    String firstname = widget.firstname;
    String surname = widget.lastname;
    String number = widget.number;

    return Container(
      height:
          ((MediaQuery.of(context).size.height - kBottomNavigationBarHeight) *
              0.14),
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
    );
  }

  _launchURL(number) async {
    bool res = await FlutterPhoneDirectCaller.callNumber(number);
  }
}
