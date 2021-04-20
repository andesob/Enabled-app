import 'package:enabled_app/contacts_page/contact_item.dart';
import 'package:enabled_app/contacts_page/contact_popup.dart';
import 'package:enabled_app/global_data/colors.dart';
import 'package:enabled_app/global_data/strings.dart';
import 'package:enabled_app/main_layout/input_controller.dart';
import 'package:enabled_app/main_layout/main_appbar.dart';
import 'package:enabled_app/page_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class contacts extends StatefulWidget {
  contacts({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _contactState createState() => _contactState();
}

class _contactState extends PageState<contacts> {
  List<ContactItem> items = [];
  int focusIndex = 0;
  int lastScollIndex = 0;
  int lastScrollIndexDown = 0;
  int lastScrollIndexUp = 0;
  final int maxScrollLength = 3;

  bool firstRun = true;
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  bool popupActive = false;

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < 20; i++) {
      ContactItem cItem = ContactItem(
        firstname: "Trym",
        surname: "Jørgensen",
        number: "95945742",
      );
      items.add(cItem);
      int cIndex = items.indexOf(cItem);
      cItem.cIndex = cIndex;
    }
  }

  setPopup(bool active) {
    popupActive = active;
  }

  ///Scrolls up to the previous contact on the list.
  void _scrollDown() {
    lastScrollIndexDown = focusIndex;
    lastScollIndex = focusIndex;
    itemScrollController.scrollTo(
        index: focusIndex, duration: Duration(seconds: 1), alignment: 0.8572);
  }

  ///Scrolls down to the next contact on the list.
  void _scrollUp() {
    lastScrollIndexUp = focusIndex;
    lastScollIndex = focusIndex;
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
    if (focusIndex > lastScrollIndexUp + 5 && focusIndex > lastScollIndex) {
      return true;
    }
    return false;
  }

  ///Adds bold font to the item in focus.
  addHighlight() {
    setState(() {
      items[focusIndex].state.setHighlightState(true);
    });
  }

  ///Removes bold font to the item not in focus any more.
  removeHighlight() {
    setState(() {
      items[focusIndex].state.setHighlightState(false);
    });
  }

  void _goBack() {
    Navigator.pushReplacementNamed(context, Strings.HOME);
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
                final ContactItem item = items[index];
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

  @override
  void leftPressed() {
    setState(() {
      if (focusIndex > 0) {
        goUp();
//      removeHighlight();
//      focusIndex--;
//      addHighlight();
//      if (canScrollUp()) {
//        itemScrollController.scrollTo(
//            index: focusIndex, duration: Duration(seconds: 1));

      }
    });
  }

  void goUp() {
    removeHighlight();
    focusIndex--;
    addHighlight();
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
    removeHighlight();
    focusIndex++;
    addHighlight();
    if (_canScrollDown()) {
      _scrollDown();
    }
  }

  /// TODO
  ///  floatingActionButton: FloatingActionButton(
//           backgroundColor: Color(StaticColors.lighterSlateGray),
//           onPressed: () {
//             showDialog(
//                 context: context,
//                 builder: (BuildContext context) {
//                   return ContactPopup(items: items);
//                 });
//           },
//           child: Icon(
//             Icons.add,
//             color: Color(StaticColors.white),
//           ),
//         ),
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
}
