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
  final firstNameController = TextEditingController();
  final surnameController = TextEditingController();
  final numberController = TextEditingController();

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
            final ContactItem item = items[index];
            return item;
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(StaticColors.lighterSlateGray),
          onPressed: (){ contactPopup();},
          child: Icon(Icons.add, color: Color(StaticColors.white),),
        ),
      ),
    );
    throw UnimplementedError();
  }

  void contactPopup(){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            title: Text('Add New Contact'),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: firstNameController,
                      decoration: InputDecoration(
                        labelText: 'First Name',
                        icon: Icon(Icons.account_box),
                      ),
                    ),
                    TextFormField(
                      controller: surnameController,
                      decoration: InputDecoration(
                        labelText: 'Surname',
                        icon: Icon(Icons.edit_sharp),
                      ),
                    ),
                    TextFormField(
                      controller: numberController,
                      decoration: InputDecoration(
                        labelText: 'Number',
                        icon: Icon(Icons.add_ic_call),
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
                    items.add(ContactItem(firstNameController.text, surnameController.text, numberController.text));
                    firstNameController.clear();
                    surnameController.clear();
                    numberController.clear();
                    Navigator.pop(context);
                  }
                  )
            ],
          );
        });
  }
}