import 'package:enabled_app/colors/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class ContactItem extends StatefulWidget {
  final String firstname;
  final String surname;
  final String number;
  int cIndex;
  _ContactItem state;
  ContactItem({Key key, this.firstname, this.surname, this.number}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    state = _ContactItem();
    return state;
  }
}

class _ContactItem extends State<ContactItem>{
  bool boldFont;

  @override
  void initState() {
    super.initState();
    print("INDEX: " + widget.cIndex.toString());
    if(widget.cIndex == 0){
      boldFont = true;
    } else {
      boldFont = false;
    }
  }

  setBold(){
    setState(() {
      boldFont = true;
    });
  }

  removeBold(){
    setState(() {
      boldFont = false;
    });
  }

  FontWeight setFontWeight(){

  }

  @override
  Widget build(BuildContext context) {
    String firstname = widget.firstname;
    String surname = widget.surname;
    String number = widget.number;

    return Container(
      height: (MediaQuery.of(context).size.height - Scaffold.of(context).appBarMaxHeight) * (0.14),
      child: ListTile(
        onTap: () => _launchURL(number),
        leading: CircleAvatar(
          backgroundColor: boldFont ? Color(StaticColors.charcoal): Color(StaticColors.lighterSlateGray),
          child: Text(
            firstname[0],
            style: TextStyle(color: Color(StaticColors.white)),
          ),
        ),
        title: Text(firstname + " " + surname, style: boldFont ? TextStyle(fontWeight: FontWeight.bold): TextStyle(fontWeight: FontWeight.normal),),
        subtitle: Text(number, style: boldFont ? TextStyle(fontWeight: FontWeight.bold): TextStyle(fontWeight: FontWeight.normal),),
      ),
    );
    throw UnimplementedError();
  }

  _launchURL(number) async {
    bool res = await FlutterPhoneDirectCaller.callNumber(number);
  }

}
