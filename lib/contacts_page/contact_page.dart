import 'dart:convert';

import 'package:enabled_app/contacts_page/contact_item.dart';
import 'package:enabled_app/contacts_page/contact_item_data.dart';
import 'package:enabled_app/contacts_page/contact_popup.dart';
import 'package:enabled_app/global_data/colors.dart';
import 'package:enabled_app/global_data/strings.dart';
import 'package:enabled_app/main_layout/input_controller.dart';
import 'package:enabled_app/main_layout/main_appbar.dart';
import 'package:enabled_app/page_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as developer;

class ContactPage extends StatefulWidget {
  ContactPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends PageState<ContactPage> {
  SharedPreferences prefs;

  List<ContactItemData> items = [];
  int focusIndex = 0;
  int lastScrollIndex = 0;
  int lastScrollIndexDown = 0;
  int lastScrollIndexUp = 0;

  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  @override
  void initState() {
    super.initState();
    initPrefs();
  }

  initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      List<String> cDataList = prefs.getStringList('contacts');
      if (cDataList == null) return;
      for (String s in cDataList) {
        ContactItemData cData = ContactItemData.fromJson(jsonDecode(s));
        items.add(cData);
      }
    });
  }

  ///Scrolls up to the previous contact on the list.
  void _scrollDown() {
    lastScrollIndexDown = focusIndex;
    lastScrollIndex = focusIndex;
    itemScrollController.scrollTo(
        index: focusIndex, duration: Duration(seconds: 1), alignment: 0.8572);
  }

  ///Scrolls down to the next contact on the list.
  void _scrollUp() {
    lastScrollIndexUp = focusIndex;
    lastScrollIndex = focusIndex;
    itemScrollController.scrollTo(
        index: focusIndex, duration: Duration(seconds: 1));
  }

  bool _canScrollUp() {
    if (focusIndex < lastScrollIndexDown - 5 && lastScrollIndexDown != 0) {
      return true;
    }
    return false;
  }

  bool _canScrollDown() {
    if (focusIndex > lastScrollIndexUp + 5 && focusIndex > lastScrollIndex) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            child: Align(
              alignment: Alignment.centerRight,
              child: FlatButton(
                child: Text("Legg til"),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return ContactPopup(items: items);
                      }).then((value) {
                    setState(() {});
                  });
                },
              ),
            ),
          ),
          Expanded(
            child: ScrollablePositionedList.builder(
              padding: EdgeInsets.all(8),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final ContactItem item = new ContactItem(
                  cData: items[index],
                  isFocused: index == focusIndex,
                  onDelete: deleteItem,
                );
                return item;
              },
              itemScrollController: itemScrollController,
              itemPositionsListener: itemPositionsListener,
            ),
          ),
        ],
      ),
    );
  }

  void deleteItem(String id) {
    setState(() {
      List<ContactItemData> removeList = [];
      for (ContactItemData cData in items) {
        if (cData.contactId == id) {
          removeList.add(cData);
        }
      }

      int numberRemoved = 0;
      for(ContactItemData cData in removeList){
        numberRemoved++;
        items.remove(cData);
      }

      updatePrefs();

      developer.log("Removed " + numberRemoved.toString() + " contact(s) from contact list");
    });
  }

  void updatePrefs(){
    List<String> prefList = [];
    for(ContactItemData cData in items){
      prefList.add(jsonEncode(cData.toJson()));
    }

    prefs.setStringList("contacts", prefList);
  }

  @override
  void leftPressed() {
    setState(() {
      if (focusIndex > 0) {
        goUp();
      }
    });
  }

  void goUp() {
    focusIndex--;
    if (_canScrollUp()) {
      _scrollUp();
    }
  }

  @override
  void pullPressed() {
    Navigator.pushReplacementNamed(context, Strings.HOME);
  }

  @override
  Future<void> pushPressed() async {
    await FlutterPhoneDirectCaller.callNumber(items[focusIndex].number);
  }

  @override
  void rightPressed() {
    setState(() {
      if (focusIndex < items.length - 1) {
        goDown();
      }
    });
  }

  void goDown() {
    focusIndex++;
    if (_canScrollDown()) {
      _scrollDown();
    }
  }
}
