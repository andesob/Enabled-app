import 'package:enabled_app/colors/colors.dart';
import 'package:enabled_app/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class contacts extends StatefulWidget {
  contacts({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _contactState createState() => _contactState();
}

/*

 */
class _contactState extends State<contacts> {
  List<ListItem> items = [];
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
        body:
        ListView.builder(
          padding: EdgeInsets.all(10),
          itemCount: items.length,
          itemBuilder: (context, index){
            final MessageItem item = items[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: Color(StaticColors.lighterSlateGray),
                  child: Text(item.sender[0],
                  style: TextStyle(color: Color(StaticColors.white)),
                  ),
                ),
              title: item.buildTitle(context),
              subtitle: item.buildSubtitle(context),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(StaticColors.lighterSlateGray),
          onPressed: (){ addItemToList();},
          child: Icon(Icons.add, color: Color(StaticColors.white),),
        ),
      ),
    );
    throw UnimplementedError();
  }

  void addItemToList(){
    setState(() {
      items.add(MessageItem("Trym", "95945742"));
    });
  }
}

abstract class ListItem {
  /// The title line to show in a list item.
  Widget buildTitle(BuildContext context);

  /// The subtitle line, if any, to show in a list item.
  Widget buildSubtitle(BuildContext context);
}

class MessageItem implements ListItem{
  final String sender;
  final String body;

  MessageItem(this.sender, this.body);

  Widget buildTitle(BuildContext context) => Text(sender);

  Widget buildSubtitle(BuildContext context) => Text(body);
  }