import 'package:enabled_app/Contacts/ContactPopup.dart';
import 'package:enabled_app/colors/colors.dart';
import 'package:enabled_app/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'ContactItem.dart';

class contacts extends StatefulWidget {
  contacts({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _contactState createState() => _contactState();
}

/*

 */
class _contactState extends State<contacts> {
  List<ContactItem> items = [];

  bool popupActive = false;

  setPopup(bool active) {
    popupActive = active;
  }

  @override
  Widget build(BuildContext context) {
    const Color lightPeach = Color(0xffffecd2);
    const Color darkPeach = Color(0xfffcb7a0);
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Container(
      decoration: new BoxDecoration(
          gradient: new LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.topRight,
              stops: [0.0, 1.0],
              colors: [lightPeach, darkPeach])),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(isPortrait ? 50 : 30),
          child: GradientAppBar(
            title: Text("Contacts Page"),
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            gradient: LinearGradient(colors: [lightPeach, darkPeach]),
          ),
        ),
        body: ListView.builder(
          padding: EdgeInsets.all(10),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final ContactItem item = items[index];
            return item;
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(StaticColors.lighterSlateGray),
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return ContactPopup(items: items);
                });
          },
          child: Icon(
            Icons.add,
            color: Color(StaticColors.white),
          ),
        ),
      ),
    );
    throw UnimplementedError();
  }
}
