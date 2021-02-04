import 'package:enabled_app/colors/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactItem extends StatelessWidget {
  final String firstname;
  final String surname;
  final String number;

  ContactItem(this.firstname, this.surname, this.number);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        onTap: () => launch("tel:" + number),
        leading: CircleAvatar(
          backgroundColor: Color(StaticColors.lighterSlateGray),
          child: Text(
            firstname[0],
            style: TextStyle(color: Color(StaticColors.white)),
          ),
        ),
        title: Text(firstname + " " + surname),
        subtitle: Text(number),
      ),
    );
    throw UnimplementedError();
  }
}
