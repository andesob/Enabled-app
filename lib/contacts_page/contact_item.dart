import 'package:enabled_app/global_data/colors.dart';
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
  /// The current highlight of font in the contact item, where true is highlighted.
  bool highlightFont;

  @override
  void initState() {
    super.initState();
    if(widget.cIndex == 0){
      highlightFont = true;
    } else {
      highlightFont = false;
    }
  }

  /// Changes the highlighting of the item
  setHighlightState(bool highlightState){
    setState(() {
      highlightFont = highlightState;
    });
  }

  @override
  Widget build(BuildContext context) {
    String firstname = widget.firstname;
    String surname = widget.surname;
    String number = widget.number;

    return Container(
      height: ((MediaQuery.of(context).size.height - kBottomNavigationBarHeight)* 0.2),
      child: ListTile(
        onTap: () => _launchURL(number),
        leading: CircleAvatar(
          backgroundColor: highlightFont ? Color(StaticColors.charcoal): Color(StaticColors.lighterSlateGray),
          child: Text(
            firstname[0],
            style: TextStyle(color: Color(StaticColors.white)),
          ),
        ),
        title: Text(firstname + " " + surname, style: highlightFont ? TextStyle(fontWeight: FontWeight.bold): TextStyle(fontWeight: FontWeight.normal),),
        subtitle: Text(number, style: highlightFont ? TextStyle(fontWeight: FontWeight.bold): TextStyle(fontWeight: FontWeight.normal),),
      ),
    );
  }

  _launchURL(number) async {
    bool res = await FlutterPhoneDirectCaller.callNumber(number);
  }

}
